//
//  CommunityNewsViewController.swift
//  gqFinal
//
//  Created by bora on 2021/05/18.
//

import UIKit
import XLPagerTabStrip

class CommunityNewsViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        let newsCell = UINib(nibName: "CommunityNewsTableViewCell", bundle: nil)
        tableView.register(newsCell, forCellReuseIdentifier: "CommunityNewsTableViewCell")
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "뉴스레터")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityNewsTableViewCell") as! CommunityNewsTableViewCell
        
        cell.selectionStyle = .none
        
        let titles: [String] = ["플라스틱 80% 감축해도 2040년 7억t 오염", "일회용 플라스틱 컵 줄이기에 정부 기업 나서다", "자고 나면 새로 솟는 ‘쓰레기산’ 1년 새 ‘100개’", "[진짜인가요] 코로나 19이후 일호용 플라스틱 사용량? 최악이다"]
        
        let contents: [String] = ["플라스틱 소비와 쓰레기 줄이기에 국제적으로 즉각적인 공동행동에 나서면 20년 동안 플라스틱 오염률이 현재 상태보다 80…", "정부, 지자체, 커피전문점, 기업 등이 플라스틱컵 사용을 줄이기 위해 만관 연합체를 결성했다.", "외신에까지 소개돼서 큰 망신을 샀던 경북 의성의 불법 쓰레기산입니다. 그런데 이 이후에도 이런 쓰레기산이 전국에서 새로…", "이렇게까지 오래갈 줄은 누가 예상이나 했을까. 신종코로나 바이러스(코로나19) 감영증 얘기다."]
        
        let imgs: [String] = ["news1", "news2", "news3", "news4"]
        
        cell.title.text = titles[indexPath.row]
        cell.content.text = contents[indexPath.row]
        let img = UIImage(named: imgs[indexPath.row])
        cell.imgView.image = img
        
        return cell
    }
    
}
