import UIKit


final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol {
 
    // MARK: - Lifecycle
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet private var counterLabel: UILabel!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var questionTitleLabel: UILabel!

    @IBOutlet private var yesButton: UIButton!
    @IBOutlet private var noButton: UIButton!
    @IBOutlet private var questionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var presenter: MovieQuizPresenter!
    var isAnsweringQuestion = false
    // MARK: - Properties
    
    
    // MARK: - Override
    
    override func viewDidLoad() {
        presenter = MovieQuizPresenter(viewController: self)
        imageView.layer.cornerRadius = 20
    }
    
    func show(quiz step: QuizStepViewModel) {
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.image = step.image
        questionLabel.text = step.question
        counterLabel.text = step.questionNumber
    }

    func show(quiz result: QuizResultsViewModel) {
        let message = presenter.makeResultsMessage()

        let alert = UIAlertController(
            title: result.title,
            message: message,
            preferredStyle: .alert)

            let action = UIAlertAction(title: result.buttonText, style: .default) { [weak self] _ in
                guard let self = self else { return }

                self.presenter.restartGame()
            }

        alert.addAction(action)

        self.present(alert, animated: true, completion: nil)
    }

    func highlightImageBorder(isCorrect isCorrectAnswer: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
    }

    func showLoadingIndicator() {
        activityIndicator.isHidden = false // говорим, что индикатор загрузки не скрыт
        activityIndicator.startAnimating() // включаем анимацию
    }

    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
    }

    func showNetworkError(message: String) {
        hideLoadingIndicator()

        let alert = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert)

            let action = UIAlertAction(title: "Попробовать ещё раз",
            style: .default) { [weak self] _ in
                guard let self = self else { return }

                self.presenter.restartGame()
            }

        alert.addAction(action)
    }
    
    @IBAction func yesButtonClicked(_ sender: Any) {
        presenter.yesButtonClicked()
        
        if !isAnsweringQuestion {
            isAnsweringQuestion = true
            yesButton.isEnabled = false
            noButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.isAnsweringQuestion = false
                self.yesButton.isEnabled = true
                self.noButton.isEnabled = true
            }
        }
    }
    
    
    @IBAction func noButtonClicked(_ sender: Any) {
        presenter.noButtonClicked()
        
        if !isAnsweringQuestion {
            isAnsweringQuestion = true
            yesButton.isEnabled = false
            noButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.isAnsweringQuestion = false
                self.yesButton.isEnabled = true
                self.noButton.isEnabled = true
            }
        }
    }
}

