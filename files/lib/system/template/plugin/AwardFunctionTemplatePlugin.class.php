<?php namespace wcf\system\template\plugin;

use wcf\system\template\TemplateEngine;
use wcf\system\WCF;
use wcf\data\award\Award;

class AwardFunctionTemplatePlugin implements IFunctionTemplatePlugin {

	public function execute ($tagArgs, TemplateEngine $tplObj) {
		$awards = Award::getAwardsByUserId($tagArgs['userID']);
		
		if ($tagArgs['assign'] !== null) {
			$tplObj->assign($tagArgs['assign'], $awards);
		}
		return '';
	}
}