//
//  PostListPageViewModelTests.swift
//  Bama-ChallangeTests
//
//  Created by Kiarash Vosough on 5/4/23.
//

@testable import Bama_Challange
import XCTest
import Dependencies

final class PostListPageViewModelTests: XCTestCase {
    
    private var sut: PostListPageViewModel!

    override func setUp() {
        sut = PostListPageViewModel()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    // Tests

    func test_initialState() throws {
        XCTAssertEqual(sut.posts, .loading)
    }

    func test_loaded_state() async throws {
        // Given
        let posts = try loadJSON(name: "posts", as: [PostListItem].self)
        let transformedPost = posts.map {
            PostListPageViewModel.PostItem(id: $0.id, title: $0.title, body: $0.body)
        }
        
        // When
        await withDependencies { values in
            values.fetchPostsUseCase = FetchPostsUseCaseStub(postListItems: posts)
        } operation: {
            await sut.load()
        }
        
        // Then
        XCTAssertEqual(sut.posts, .loaded(transformedPost))
    }

    func test_error_state() async throws {
        enum CustomError: Error, Equatable {
            case error
        }
        // Given
        let message = "Failed To Load"
        let error = CustomError.error
        
        // When
        await withDependencies { values in
            values.fetchPostsUseCase = FetchPostsUseCaseStub(postListItemsError: error)
        } operation: {
            await sut.load()
        }
        
        // Then
        XCTAssertEqual(sut.posts, .failed(message: message))
    }

    func test_on_post_tap() async throws {
        // Given
        let id: Int32 = 1
        let postItem = PostListPageViewModel.PostItem(id: id, title: .shortValue, body: .shortValue)
        let actions: MockActions<TapPostItemUseCaseStub.Action> = MockActions(expected: [
            .postTapped(id: id)
        ])

        // When
        withDependencies { values in
            values.tapPostItemUseCase = TapPostItemUseCaseStub(actions: actions)
        } operation: {
            sut.onPostTapped(postItem)
        }

        // Then
        actions.verify()
    }
}
