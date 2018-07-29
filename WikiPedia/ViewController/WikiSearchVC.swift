//
//  WikiSearchVC.swift
//  WikiPedia
//
//  Created by Magna on 28/07/18.
//  Copyright © 2018 Rajasekhar. All rights reserved.
//

import UIKit
import SafariServices
import CoreData
class WikiSearchVC: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    @IBOutlet var txt_keywords: UITextField!
    @IBOutlet var tableView: UITableView!
    var serachResult : SearchResult?
    var pageResults  : [PagesSet]?
    var dbPageResult : PagesSet?
    var searchViewModel = [SearchViewModel]()
    public var database = Database()
    var searchDbData : [SearchData] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "WikiSearch"
        self.navigationItem.hidesBackButton = true
         self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        //if you want see data remove commentLine
//        coredataFetchData()
    }
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func searchBtn_action(_ sender: UIButton) {
        txt_keywords.resignFirstResponder()
       sender.flash()
       getData()
}
// MARK: - TexfieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
}
// MARK: - WebService
 fileprivate func getData(){
    let whiteSpaceStr = txt_keywords.text!.replacingOccurrences(of: " ", with: "")
    let urlStr : String? = "\(Keys.BASEURL)&\(Keys.GpsSearch)=\(whiteSpaceStr)&\(Keys.GpsLimit)=20"
        ServiceHandler.sharedInstance.fetchFeaturedApps(urlStr ?? "", { (serachResult) in
            self.pageResults = serachResult.query?.pages
            self.searchViewModel = self.pageResults?.map({return SearchViewModel(page: $0)}) ?? []
            //Offline Storing
            self.searchDbData.removeAll()
            _ = self.pageResults?.map({self.database.insertSearchResults(data:$0)})
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
}
    // MARK: - TableviewMethods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = pageResults?.count {
            return count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Search") as? SearchTableViewCell else {
            return UITableViewCell()
        }
//   database.insertSearchResults(data: self.pageResults![indexPath.row])
        let searchViewModel = self.searchViewModel[indexPath.row]
        cell.pageDispalyModel = searchViewModel
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let displayUrl = self.pageResults![indexPath.row]
        if let url = displayUrl.thumbnail?.source{
            let  safariVc = SFSafariViewController.init(url: URL(string: url)! )
            safariVc.view.tintColor = UIColor.red
            safariVc.delegate  = self
            self.present(safariVc, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let trasform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform  = trasform
        UIView.animate(withDuration: 1.0) {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // MARK: - CoredataFetch
    fileprivate func coredataFetchData() {
        let managedContext = appDelegate.persistentContainer.viewContext
        let watchlistData : NSFetchRequest = SearchData.fetchRequest()
        watchlistData.returnsObjectsAsFaults = false
        searchDbData = try! managedContext.fetch(watchlistData)
    }
}
extension WikiSearchVC : SFSafariViewControllerDelegate{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
extension UIButton{
    fileprivate func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5;  flash.fromValue = 1;   flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        flash.autoreverses = true;  flash.repeatCount = 1
        layer.add(flash, forKey: nil)
    }
}

