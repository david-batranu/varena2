<?php 

require_once '../../lib/Util.php';

$method = Util::get('method');
$email = Util::get('email');
$name = Util::get('name');
$password = Util::get('password');
$password2 = Util::get('password2');
$remember = Util::getCheckbox('remember');
$errors = [];

if ($method == 'login') {
  $u = User::get_by_email($email);
  if ($u && password_verify($password, $u->password)) {
    Session::login($u, $remember);
  } else {
    $errors = [ _('Incorrect email or password.') ];
  }
} else if ($method == 'signup') {
  $u = Model::factory('User')->create();
  $u->email = $email;
  $u->name = $name;
  $u->password = $password;
  $errors = $u->validate();
  if ($password != $password2) {
    $errors[] = _("Passwords don't match.");
  }
  if (!count($errors)) {
    $u->password = password_hash($password, PASSWORD_DEFAULT);
    $u->save();
  }
}

SmartyWrap::assign('errors', $errors);
SmartyWrap::assign('email', $email);
SmartyWrap::assign('name', $name);
SmartyWrap::assign('remember', $remember);
SmartyWrap::display('auth/login.tpl');

?>
