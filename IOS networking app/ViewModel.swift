//
//  ViewModel.swift
//  IOS networking app
//
//  Created by Ansh Shukla on 13/04/24.
//

import Foundation

@MainActor // ensures the viewmodel runs on main thread
class ViewModel: ObservableObject {
    enum Status{
        case NOT_STARTED
        case IN_PROGRESS
        case SUCCESS(data: (quote: Quote, character: Character))
        case FAILURE(error: Error)
    }
    
    // declaring that a view can observe t his property
    @Published private(set) var status: Status = .NOT_STARTED
    // private set -> property can only be changed here, but observable elsewhere
    
    private let controller: FetchController
    
    init(controller: FetchController) {
        // initislise properties in viewModel
        self.controller = controller // self = viewmodel
    }
    
    func getData(for show: String) async {
        status = .IN_PROGRESS
        do {
            let quote = try await controller.fetchQuote(from: show)
            let character = try await controller.fetchCharacter(quote.character)
            status = .SUCCESS(data: (quote, character))
        } catch {
            status = .FAILURE(error: error)
        }
    }
}
