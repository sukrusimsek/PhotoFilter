//
//  SettingScreen.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 6.03.2024.
//

import UIKit
protocol SettingScreenInterface: AnyObject {
    func configureVC()
    func configureTableView()
}
final class SettingScreen: UIViewController {
    private let viewModel = SettingViewModel()
    let sections = ["FILTERCRAFT", "OTHER"]
    let supportOptions = ["Send Feedback", "Share"]
    let discoverOptions = ["My Other Apps", "Licence", "Contact Us"]
    let tableView = UITableView()
    let versionLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}
extension SettingScreen: SettingScreenInterface, UITableViewDelegate, UITableViewDataSource {
    func configureVC() {
        title = "Settings"
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.textColor = .white
        view.backgroundColor = UIColor(rgb: 0x1e1e1e)
        versionLabel.text = "Version 1.0"
        tableView.addSubview(versionLabel)
        NSLayoutConstraint.activate([
            versionLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            versionLabel.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
        ])
        navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(tappedBackPage), imageName: "backButton", height: 32, width: 32)
        
    }
    @objc func tappedBackPage() {
        navigationController?.popViewController(animated: true)
    }
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(rgb: 0x1e1e1e)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return supportOptions.count
        case 1:
            return discoverOptions.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor(rgb: 0x1e1e1e)
        var iconName = ""
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                iconName = "iconForSendFeedback"
            } else if indexPath.row == 1 {
                iconName = "iconForShare"
            }
            cell.textLabel?.text = supportOptions[indexPath.row]
        case 1:
            if indexPath.row == 0 {
                iconName = "iconForMyOtherApps"
            } else if indexPath.row == 1 {
                iconName = "iconForLicence"
            } else if indexPath.row == 2 {
                iconName = "iconForContactUs"
            }
            cell.textLabel?.text = discoverOptions[indexPath.row]
        
        default:
            break
        }
        let iconSize = CGSize(width: 24, height: 24)
        let icon = UIImage(named: iconName)?.resizedImage(to: iconSize)
        cell.imageView?.image = icon
        cell.textLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("index: \(indexPath.row)")
        switch indexPath.section {
        case 0:
            performActionForSection0Row(at: indexPath.row)
        case 1:
            performActionForSection1Row(at: indexPath.row)
        default:
            break
        }
        
    }
    func performActionForSection0Row(at index: Int) {
        switch index {
        case 0:
            if let websiteURL = URL(string: "http://www.linkedin.com/in/sukrusimsek") {
                if UIApplication.shared.canOpenURL(websiteURL) {
                    UIApplication.shared.open(websiteURL, options: [:], completionHandler: nil)
                }
            }
            break
        case 1:
            if let websiteURL = URL(string: "http://www.linkedin.com/in/sukrusimsek") {
                if UIApplication.shared.canOpenURL(websiteURL) {
                    UIApplication.shared.open(websiteURL, options: [:], completionHandler: nil)
                }
            }
            break
        default:
            break
        }
    }
    func performActionForSection1Row(at index: Int) {
        switch index {
        case 0:
            if let websiteURL = URL(string: "https://apps.apple.com/tr/developer/sukru-simsek/id1728509670?l=tr") {
                if UIApplication.shared.canOpenURL(websiteURL) {
                    UIApplication.shared.open(websiteURL, options: [:], completionHandler: nil)
                }
            }
            break
        case 1:
            if let websiteURL = URL(string: "http://www.github.com/sukrusimsek") {
                if UIApplication.shared.canOpenURL(websiteURL) {
                    UIApplication.shared.open(websiteURL, options: [:], completionHandler: nil)
                }
            }
            break
        case 2:
            if let websiteURL = URL(string: "http://www.github.com/sukrusimsek") {
                if UIApplication.shared.canOpenURL(websiteURL) {
                    UIApplication.shared.open(websiteURL, options: [:], completionHandler: nil)
                }
            }
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        switch sections[section] {
        case "FILTERCRAFT":
            headerView.backgroundColor = UIColor.clear
        case "OTHER":
            headerView.backgroundColor = UIColor.clear
        default:
            break
        }
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = sections[section]
        label.textColor = UIColor(white: 1, alpha: 0.5)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        headerView.addSubview(label)
        NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
                label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
                label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
                label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5)
            ])
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let containerHeight: CGFloat = 20
            let separatorHeight: CGFloat = 1
            let separatorYPosition = containerHeight - separatorHeight

            let containerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: containerHeight))
            containerView.backgroundColor = .clear

            let separatorView = UIView(frame: CGRect(x: 0, y: separatorYPosition, width: tableView.frame.width, height: separatorHeight))
            separatorView.backgroundColor = UIColor(white: 1, alpha: 0.1)
            containerView.addSubview(separatorView)

            return containerView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        }
        return 0
    }



    
}
