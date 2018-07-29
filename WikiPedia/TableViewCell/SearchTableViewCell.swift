//
//  SearchTableViewCell.swift
//  WikiPedia
//
//  Created by Magna on 28/07/18.
//  Copyright © 2018 Rajasekhar. All rights reserved.
//

import UIKit
class SearchTableViewCell: UITableViewCell {
    @IBOutlet var img_disaply: UIImageView!
    @IBOutlet var lbl_description: UILabel!
    @IBOutlet var lbl_tittle: UILabel!
    var pageDispalyModel : SearchViewModel?{
        didSet{
            let descStr = "\(pageDispalyModel?.description ?? [""])"
            let filterStr = String(descStr.filter { !"\"[]".contains($0) })
            lbl_description.text = filterStr
            lbl_tittle.text = pageDispalyModel?.tittle
            img_disaply.sd_setImage(with: URL(string: (pageDispalyModel?.imgsourceUrl) ?? ""), placeholderImage: #imageLiteral(resourceName: "placeHolder"))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
