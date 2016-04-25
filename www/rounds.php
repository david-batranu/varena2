<?php

require_once '../lib/Util.php';

$rounds = Model::factory('Round')
        ->order_by_desc('start')
        ->find_many();

$user = Session::getUser();


const STATUS_CLASSES = [
  Round::STATUS_EXPIRED => 'bg-danger',
  Round::STATUS_ONGOING => 'bg-success',
  Round::STATUS_UPCOMING => 'bg-info'
];

function getRoundStateClass($round){
  return STATUS_CLASSES[$round->getStatus()];
}


SmartyWrap::registerPlugin('modifier', 'round_class', 'getRoundStateClass');
SmartyWrap::assign('rounds', $rounds);
SmartyWrap::assign('canAdd', $user && $user->can(Permission::PERM_ROUND));
SmartyWrap::display('rounds.tpl');

?>
