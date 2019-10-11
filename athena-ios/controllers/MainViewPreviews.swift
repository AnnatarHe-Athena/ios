//
//  MainViewPreviews.swift
//  athena-ios
//
//  Created by annatar.he on 2019/10/8.
//  Copyright © 2019 AnnatarHe. All rights reserved.
//

import SwiftUI

#if DEBUG

struct MainViewControllerPreviews : PreviewProvider, UIViewControllerRepresentable {
    
    // MARK: PreviewProvider
    
    static var previews: some View {
        
        MainViewControllerPreviews()
    }
    
    // MARK: UIViewControllerRepresentable
    
    typealias UIViewControllerType = MainViewController
    
    func makeUIViewController(
        context: Context
    ) -> MainViewController {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController: MainViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainController") as! MainViewController
        
        return mainViewController
    }
    
    func updateUIViewController(
        _ uiViewController : MainViewController, context: Context) {
        
    }
}

#endif
