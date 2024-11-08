import UIKit

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var alreadyRegisterLoginLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profilePictureImageView.contentMode = .scaleAspectFill
        self.profilePictureImageView.layer.masksToBounds = true
        
        let profilePictureImageViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onTapProfilePictureImageView))
        self.profilePictureImageView.isUserInteractionEnabled = true
        self.profilePictureImageView.addGestureRecognizer(profilePictureImageViewTapGesture)
        
        let alreadyRegisterLoginLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onTapAlreadyRegisterLoginLabel))
        self.alreadyRegisterLoginLabel.isUserInteractionEnabled = true
        self.alreadyRegisterLoginLabel.addGestureRecognizer(alreadyRegisterLoginLabelTapGesture)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let minSide = min(self.profilePictureImageView.frame.width, self.profilePictureImageView.frame.height)
        self.profilePictureImageView.layer.cornerRadius = minSide / 2
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        AuthService.register(firstname: self.firstnameTextField.text!, lastname: self.lastnameTextField.text!, email: self.emailTextField.text!, password: self.passwordTextField.text!, profilePicture: (self.profilePictureImageView.image?.jpegData(compressionQuality: 0.8) ?? UIImage(named: "placeholder")?.jpegData(compressionQuality: 0.8))!) {
            if(AuthService.token != nil) {
                self.navigationController?.pushViewController(MainViewController(), animated: true)
            }
            else {
                ViewUtils.showToast(message: AuthService.message!, in: self)
            }
        }
    }
    
    @objc func onTapProfilePictureImageView() {
        let imagePicker: UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            self.profilePictureImageView.image = editedImage
        }
        else if let originalImage = info[.originalImage] as? UIImage {
            self.profilePictureImageView.image = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func onTapAlreadyRegisterLoginLabel() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}
