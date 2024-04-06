//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Alejandro Cervantes on 2024-03-18.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    //Request Models
    var profile: Profile?
    
    //View models
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "", name: "", date: Date())
    
    var accountCellViewModels: [AccountSummaryCell.ViewModel] = []
    
    var tableView = UITableView()
    
    var headerView = AccountSummaryHeaderView(frame: .zero)
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationBar()
    }
}

extension AccountSummaryViewController {
    
    private func setup() {
        setupTableView()
        setupTableHeaderView()
        fetchDataAndLoadViews()
    }
    
    private func setupTableView() {
        
        tableView.backgroundColor = appColor
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseId)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupTableHeaderView() {
        
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        size.width = UIScreen.main.bounds.width
        
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
}

extension AccountSummaryViewController {
    private func fetchAccounts() {
        
        let savings = AccountSummaryCell
            .ViewModel(accountType: .Banking,accountName: "Basic Savings",balance: 929466.23)
        let chequing = AccountSummaryCell
            .ViewModel(accountType: .Banking,accountName: "No-Fee All-In Chequing",balance: 17562.44)
        let visa = AccountSummaryCell
            .ViewModel(accountType: .CreditCard,accountName: "Visa Avion Card",balance: 412.83)
        let masterCard = AccountSummaryCell
            .ViewModel(accountType: .CreditCard,accountName: "Student Mastercard",balance: 50.83)
        let investment1 = AccountSummaryCell
            .ViewModel(accountType: .Investment,accountName: "Tax-Free Saver",balance: 2000.00)
        let investment2 = AccountSummaryCell
            .ViewModel(accountType: .Investment,accountName: "Growth Fund",balance: 15000.00)

        accountCellViewModels.append(savings)
        accountCellViewModels.append(chequing)
        accountCellViewModels.append(visa)
        accountCellViewModels.append(masterCard)
        accountCellViewModels.append(investment1)
        accountCellViewModels.append(investment2)
    }
}

// MARK: - UITableView Data Source
extension AccountSummaryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !accountCellViewModels.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseId, for: indexPath) as! AccountSummaryCell
        
        let account = accountCellViewModels[indexPath.row]
        
        cell.configure(with: account)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModels.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: Actions
extension AccountSummaryViewController {
    @objc func logoutTapped(sender: UIButton) {
        NotificationCenter.default.post(name: .Logout, object: nil)
    }
}

// MARK: - Networking
extension AccountSummaryViewController {
    private func fetchDataAndLoadViews() {
        
        fetchProfile(forUserId: "1") { result in
            switch result {
            case .success(let profile):
                self.profile = profile
                self.configureTableHeaderView(with: profile)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        fetchAccounts()
    }
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,",
                                                    name: profile.firstName,
                                                    date: Date())
        headerView.configure(viewModel: vm)
    }
}
