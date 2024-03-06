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
    let sections = ["SUPPORT", "EXPLORE OTHER APPS", "PRIVACY POLICY & LEGAL NOTICE"]
    let supportOptions = ["Send Feedback", "Write Comment", "Share"]
    let discoverOptions = ["My Other Apps", "Licence"]
    let legalOptions = ["Privacy Policy", "Terms of Use", "Legal Notice"]
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
        versionLabel.text = "Version 1.0"
        tableView.addSubview(versionLabel)
        NSLayoutConstraint.activate([
            versionLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            versionLabel.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            
//            versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            versionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .lightGray
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
        case 2:
            return legalOptions.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .lightText
        var iconName = ""
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                iconName = "square.and.arrow.up"
            } else if indexPath.row == 1 {
                iconName = "square.and.arrow.down"
            } else if indexPath.row == 2 {
                iconName = "arrow.clockwise"
            }
            cell.textLabel?.text = supportOptions[indexPath.row]
        case 1:
            if indexPath.row == 0 {
                iconName = "rectangle.on.rectangle"
            } else if indexPath.row == 1 {
                iconName = "rectangle.split.3x3"
            }
            cell.textLabel?.text = discoverOptions[indexPath.row]
        case 2:
            if indexPath.row == 0 {
                iconName = "doc.text"
            } else if indexPath.row == 1 {
                iconName = "doc.richtext"
            } else if indexPath.row == 2 {
                iconName = "doc.plaintext"
            }
            cell.textLabel?.text = legalOptions[indexPath.row]
        default:
            break
        }
        cell.textLabel?.textColor = .black
        cell.imageView?.image = UIImage(systemName: iconName)
        cell.imageView?.tintColor = .black
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
        case 2:
            performActionForSection2Row(at: indexPath.row)
            // Diğer seçenekler için gerekli kontroller
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
        case 2:
            let textToShare = "Uygulamayı denemelisin!"
            let appURL = URL(string: "https://apps.apple.com/tr/developer/sukru-simsek/id1728509670?l=tr")!

            let activityViewController = UIActivityViewController(activityItems: [textToShare, appURL], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
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
        default:
            break
        }
    }
    func performActionForSection2Row(at index: Int) {
        switch index {
        case 0:
            if let websiteURL = URL(string: "http://www.github.com/sukrusimsek") {
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
        case "SUPPORT":
            headerView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        case "EXPLORE OTHER APPS":
            headerView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        case "PRIVACY POLICY & LEGAL NOTICE":
            headerView.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        default:
            break
        }
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = sections[section]
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
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
}
