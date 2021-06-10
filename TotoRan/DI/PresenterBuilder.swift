//
//  PresenterBuilder.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/15.
//

import Domain

class PresenterBuilder {
    private let repositoryProvider: RepositoryProvider = RepositoryProvider()
    
    func createInitialViewPresenter(view: InitialViewable) -> InitialViewPresentable {
        InitialViewPresenter(view: view, dataHandleUseCase: makeDataHandleUseCase())
    }
    
    func createRateChartViewPresenter(view: RateChartViewable) -> RateChartViewPresentable {
        RateChartViewPresenter(view: view, dataHandleUseCase: makeDataHandleUseCase())
    }
    
    func createChoiceViewPresenter(view: ChoiceViewable) -> ChoiceViewPresentable {
        ChoiceViewPresenter(view: view, dataHandleUseCase: makeDataHandleUseCase())
    }
    
    func createResultViewPresenter(view: ResultViewable, choiceDataModel: ChoiceDataModel) -> ResultViewPresentable {
        ResultViewPresenter(view: view, choiceDataModel: choiceDataModel)
    }
    
    func createJudgeResultViewPresenter(view: JudgeResultViewable, choiceDataList: [ChoiceData]) -> JudgeResultViewPresentable {
        JudgeResultViewPresenter(view: view, dataHandleUseCase: makeDataHandleUseCase(), choiceDataList: choiceDataList)
    }
    
    private func makeDataHandleUseCase() -> DataHandleUseCase {
        DataHandleUseCaseImpl(totoDataRepository: repositoryProvider.provideTotoDataRepository())
    }
    
}
