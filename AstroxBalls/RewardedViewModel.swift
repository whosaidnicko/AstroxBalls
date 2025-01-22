//
//  RewardedViewModel.swift
//  AstroxBalls
//
//  Created by Nicolae Chivriga on 07/12/2024.
//

import GoogleMobileAds
import SwiftUI

class RewardedViewModel: NSObject, ObservableObject, GADFullScreenContentDelegate {
    
    @AppStorage("coins") var coins = 0
    @Published var isAdLoaded = false
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    
    private var rewardedAd: GADRewardedAd?
  
    func loadAd() {
        let request = GADRequest()
        GADRewardedAd.load(
            withAdUnitID: "ca-app-pub-3940256099942544/1712485313",
            request: request
        ) { [weak self] ad, error in
            if let error = error {
                print("Failed to load rewarded ad: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.isAdLoaded = false
                    self?.errorMessage = error.localizedDescription
                    self?.showErrorAlert = true
                }
                return
            }
            self?.rewardedAd = ad
            self?.rewardedAd?.fullScreenContentDelegate = self
            DispatchQueue.main.async {
                self?.isAdLoaded = true
            }
        }
    }
    
    func showAd(from viewController: UIViewController) {
        guard let rewardedAd = rewardedAd else {
            print("Ad wasn't ready.")
            return
        }
        
        rewardedAd.present(fromRootViewController: viewController) { [weak self] in
            self?.addCoins(Int(truncating: 40))
        }
    }
    
    private func addCoins(_ amount: Int) {
        coins += amount
    }
    
    // MARK: - GADFullScreenContentDelegate Methods
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss.")
        isAdLoaded = false
        loadAd()
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad failed to present with error: \(error.localizedDescription)")
        isAdLoaded = false
        errorMessage = error.localizedDescription
        showErrorAlert = true
    }
}
