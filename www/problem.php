<?php

require_once '../lib/Util.php';

$id = Request::get('id');

$problem = Problem::get_by_id($id);

if (!$problem) {
  FlashMessage::add(_('Problem not found.'));
  Util::redirect(Util::$wwwRoot);
}

SmartyWrap::assign('problem', $problem);
SmartyWrap::display('problem.tpl');

?>