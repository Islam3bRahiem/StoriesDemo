//
//  ViewController.swift
//  StoriesDemo
//
//  Created by Islam 3bRahiem on 3/24/20.
//  Copyright © 2020 Organization. All rights reserved.
//

import UIKit

class Home: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var storyCollectionView: UICollectionView! {
        didSet {
            storyCollectionView.tag = 0
            storyCollectionView.delegate = self
            storyCollectionView.dataSource = self
            storyCollectionView.register(UINib(nibName: "StoryCell", bundle: nil), forCellWithReuseIdentifier: "StoryCell")
        }
    }

    
    private var stories = [UserStories]()
    private let interactor = HomeAPI()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stories"
        fetchData()
    }
    
    private func fetchData() {
        interactor.getHomeData(didDataReady: { [weak self](response) in
            guard self != nil else { return }
            if response.status == StatusCode.Success.rawValue {
                self?.stories = response.stories ?? []
                self?.storyCollectionView.reloadData()
            }
        })
    }


}

extension Home: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as? StoryCell else {
            return UICollectionViewCell()
        }
        let s = stories[indexPath.row]
        cell.configure(image: s.image, name: s.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let storyPreviewScene = IGStoryPreviewController.init(stories: self.stories, handPickedStoryIndex:  indexPath.row-1)
            self.present(storyPreviewScene, animated: true, completion: nil)
        }
    }
    
    
}


