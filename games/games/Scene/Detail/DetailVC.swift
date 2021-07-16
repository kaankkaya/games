//
//  DetailVC.swift
//  games
//
//  Created by Kaan Kaya on 13.07.2021.
//

import UIKit

final class DetailVC: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    var vm: DetailVM! {
        didSet {
            vm.delegate = self
        }
    }
    
    private var descriptionHeight: CGFloat = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.load()
        
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(favoriteTapped))
        navigationController?.navigationBar.sizeToFit()
        
        tableView.separatorColor = .clear
    }
    
    // MARK: - Helpers
    @objc private func favoriteTapped() {
        
    }
}

extension DetailVC: DetailVMDelegate {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func handleImage(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            let container = UIView(frame: CGRect(x: 0, y: 0, width: self!.tableView.frame.width, height: 250))
            container.backgroundColor = .red
            
            let gradient = CAGradientLayer()
            gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            gradient.locations = [0.0, 1.0]
            gradient.frame = container.bounds
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self!.tableView.frame.width, height: 250))
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            
            container.addSubview(imageView)
            
            container.layer.insertSublayer(gradient, above: imageView.layer)
            
            self?.tableView.tableHeaderView = container
        }
    }
}

extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.item != nil ? 3 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = vm.item else {
            print("No detail item found to show!")
            
            return UITableViewCell()
        }
        let cell: UITableViewCell
        
        switch indexPath.row {
        case GenreCell.index:
            let nCell = tableView.dequeueReusableCell(withIdentifier: "GenreCell") as! GenreCell
            let genreString = item.genres.map { $0.name }.joined(separator: ", ")
            nCell.setText(genreString)
            cell = nCell
        case DescriptionCell.index:
            let nCell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell") as! DescriptionCell
            let descriptionData = Data(item.description.utf8)
            let attributedString = try? NSAttributedString(data: descriptionData,
                                                              options: [.documentType: NSAttributedString.DocumentType.html],
                                                              documentAttributes: nil)
            nCell.setText(attributedString?.string ?? "")
            descriptionHeight = nCell.getDescriptionHeight()
            cell = nCell
        case LinkCell.index:
            let nCell = tableView.dequeueReusableCell(withIdentifier: "LinkCell") as! LinkCell
            nCell.url = URL(string: item.website)
            cell = nCell
        default: fatalError("Extra cell in Detail VC!")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == DescriptionCell.index
            ? descriptionHeight
            : 44
    }
}
