import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var noYetRegisteredRegisterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let noYetRegisteredRegisterLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onTapNoYetRegisteredRegisterLabel))
        self.noYetRegisteredRegisterLabel.isUserInteractionEnabled = true
        self.noYetRegisteredRegisterLabel.addGestureRecognizer(noYetRegisteredRegisterLabelTapGesture)
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        AuthService.login(email: self.emailTextField.text!, password: self.passwordTextField.text!) {
            if(AuthService.token != nil) {
                UserService.getUserIdByToken(token: AuthService.token!) {
                    UserService.getUserConnected(id: UserService.userId!) {
                        DispatchQueue.main.async {
                            self.navigationController?.pushViewController(MainViewController(), animated: true)
                        }
                    }
                }
            }
            else {
                ViewUtils.showToast(message: AuthService.message!, in: self)
            }
        }
    }
    
    @objc func onTapNoYetRegisteredRegisterLabel() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}
