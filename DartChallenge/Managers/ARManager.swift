//
//  ARManager.swift
//  DartChallenge
//
//  Created by thaxz on 02/10/23.
//

import Foundation
import Combine
import RealityKit

class ARManager {
   
    static let shared = ARManager()
    private init () {}
    
    // Passing a value so someone else can subscribe into it and use its value
    // The first value is what we want to pass throught and the second is any error than can be thrown
    // Ours is never because we're telling that this action can never fails
    var actionsStream = PassthroughSubject<ARAction, Never>()
    
    typealias LoadCompletion = (Result<DartEntity, Error>) -> Void
    
    private var loadCancellable: AnyCancellable?
    private var dartEntity: DartEntity?
    
    // LOAD
    func loadResources(completion: @escaping LoadCompletion) -> AnyCancellable? {
        guard let dartEntity else {
            loadCancellable = DartEntity.loadAsync.sink { result in
                if case let .failure(error) = result {
                    print("Failed to load PancakeEntity: \(error)")
                    completion(.failure(error))
                }
            } receiveValue: { [weak self] dartEntity in
                guard let self else {
                    return
                }
                self.dartEntity = dartEntity
                completion(.success(dartEntity))
            }
            return loadCancellable
        }
        completion(.success(dartEntity))
        return loadCancellable
    }
    
    // CREATE
    func createDart() throws -> Entity {
        guard let dart = dartEntity?.dartModel else {
            throw ResourceLoaderError.resourceNotLoaded
        }
        return dart.clone(recursive: true)
    }
    
    
    
}

enum ResourceLoaderError: Error {
    case resourceNotLoaded
}
