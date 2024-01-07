//
//  ApıCaller.swift
//  MultiScreenAewsApplicationAndDesign
//
//  Created by Fatih on 6.01.2024.
//

import Foundation

struct ApıCaller {
    
    static let shared = ApıCaller()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=3001e8b87ef24c08b567c2fd03d80142")
        static let techURL = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2023-12-07&sortBy=publishedAt&apiKey=3001e8b87ef24c08b567c2fd03d80142")
        static let scienceURL = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=3001e8b87ef24c08b567c2fd03d80142")
        static let educationURL = URL(string: "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=3001e8b87ef24c08b567c2fd03d80142")
        static let businessURL = URL(string: "https://newsapi.org/v2/everything?q=apple&from=2024-01-06&to=2024-01-06&sortBy=popularity&apiKey=3001e8b87ef24c08b567c2fd03d80142")
        
    }
    private init() { }
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Articles: \(result.articles!.count)")
                    completion(.success(result.articles!))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func fetchNewsByCategory(category: MenuType, completion: @escaping (Result<[Article], Error>) -> Void) {
        var requestURL: URL?
        
        switch category {
        case .tech:
            guard let url = Constants.techURL else {
                return
            }
            requestURL = url
        case .science:
            guard let url = Constants.scienceURL else {
                return
            }
            requestURL = url
        case .education:
            guard let url = Constants.educationURL else {
                return
            }
            requestURL = url
        case .business:
            guard let url = Constants.businessURL else {
                return
            }
            requestURL = url
        }
        
        
        if let url = requestURL {
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                }
                else if let data = data {
                    do {
                        let result = try JSONDecoder().decode(APIResponse.self, from: data)
                        print("Articles: \(result.articles!.count)")
                        completion(.success(result.articles!))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
        

    }
}



//MARK: - MODELS

// MARK: - APIResponse
struct APIResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}
