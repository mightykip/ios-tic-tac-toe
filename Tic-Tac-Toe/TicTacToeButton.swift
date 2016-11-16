//
//  TicTacToeBoardPiece.swift
//  Tic-Tac-Toe
//
//  Created by Kip Lawrence on 11/16/16.
//  Copyright © 2016 Kip Lawrence. All rights reserved.
//

import UIKit

@IBDesignable
class TicTacToeButton: UIButton {
    
    @IBInspectable
    private var imageForX: UIImage? = nil
    @IBInspectable
    private var imageForO: UIImage? = nil
    @IBInspectable
    var pieceShowing = XorO.x { didSet { updateUI() } }
    
    enum XorO: Int {
        case x = 0
        case o = 1
        case blank = 3
    }

    private func updateUI() {
        switch pieceShowing {
        case .x:
            self.setImage(imageForX!, for: .normal)
        case .o:
            self.setImage(imageForO!, for: .normal)
        case .blank:
            self.setImage(nil, for: .normal)
        }
        setNeedsDisplay()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    private func customInit() {
        if let url = NSURL(string: "https://d13yacurqjgara.cloudfront.net/users/14765/screenshots/2231573/fancy-x-cap-..._1x.png") {
            if let data = NSData(contentsOf: url as URL) {
                imageForX = UIImage(data: data as Data)
                updateUI()
            }
        }
        if let url = NSURL(string: "https://s-media-cache-ak0.pinimg.com/236x/29/34/28/2934282cc01f6a70a06c5e403d76743b.jpg") {
            if let data = NSData(contentsOf: url as URL) {
                imageForO = UIImage(data: data as Data)
                updateUI()
            }
        }
    }

}
