{include file='header' pageTitle='wcf.acp.award.action.'|concat:$action}

<script data-relocate="true">
	//<![CDATA[
	$(function() {
		WCF.TabMenu.init();
		new WCF.Search.User('#issueUsername', null, false, [ ], false);
	});
	//]]>
</script>

<header class="boxHeadline">
	<h1>{lang}wcf.acp.award.action.{$action}{/lang}</h1>
</header>

{if $success|isset}
	<p class="success">{lang}wcf.global.success.{$action}{/lang}</p>
{/if}

<div class="contentNavigation">
	<nav>
		<ul>
			{event name='contentNavigationButtons'}
		</ul>
	</nav>
</div>

<div class="tabMenuContainer" data-active="{$activeTabMenuItem}" data-store="activeTabMenuItem">
	<nav class="tabMenu">
		<ul>
			<li><a href="{@$__wcf->getAnchor('general')}">{lang}wcf.acp.award.category.general{/lang}</a></li>
			{if $action == 'edit'}<li><a href="{@$__wcf->getAnchor('issue')}">{lang}wcf.acp.award.category.issue{/lang}</a></li>{/if}
			
			{event name='tabMenuTabs'}
		</ul>
	</nav>
	
	<div id="general" class="container containerPadding tabMenuContent">
		<form method="post" action="{if $action == 'add'}{link controller='awardActionAdd'}{/link}{else}{link controller='awardActionEdit'}{/link}{/if}">
			<fieldset>
				<legend>{lang}wcf.acp.award.action.general{/lang}</legend>
				<dl>
					<dt><label for="awardName">{lang}wcf.acp.award.action.name{/lang}</label></dt>
					<dd>
						<input id="awardName" name="awardName" value="{if $award[awardName]}{$award[awardName]}{/if}" type="text" class="medium" />
					{*if $errorField == 'awardName'*}
						<!--<small class="innerError">
							{*if $errorType == 'empty'*}
								{lang}wcf.global.form.error.empty{/lang}
							{*/if*}
						</small>-->
					{*/if*}
					</dd>
				</dl>
				<dl>
					<dt><label for="awardCategory">{lang}wcf.acp.award.action.category{/lang}</label></dt>
					<dd>
						<input id="awardCategory" name="awardCategory" value="{if $award[awardCategory]}{$award[awardCategory]}{/if}" type="text" class="medium" />
						<small>{lang}wcf.acp.award.action.category.description{/lang}</small>
					{*if $errorField == 'awardCategory'*}
						<!--<small class="innerError">
							{*if $errorType == 'empty'*}
								{lang}wcf.global.form.error.empty{/lang}
							{*/if*}
						</small>-->
					{*/if*}
					</dd>
				</dl>
				<dl>
					<dt><label for="awardDescription">{lang}wcf.acp.award.action.description{/lang}</label></dt>
					<dd>
						<textarea id="awardDescription" name="awardDescription" cols="40" rows="5">{if $award[awardDescription]}{$award[awardDescription]}{/if}</textarea>
					{*if $errorField == 'awardDescription'*}
						<!--<small class="innerError">
							{*if $errorType == 'empty'*}
								{lang}wcf.global.form.error.empty{/lang}
							{*/if*}
						</small>-->
					{*/if*}
					</dd>
				</dl>
				<dl>
					<dt><label for="relevance">{lang}wcf.acp.award.action.relevance{/lang}</label></dt>
					<dd>
						<input type="number" id="relevance" name="relevance" value="{if $award[relevance]}{@$award[relevance]}{/if}" class="tiny" min="0" />
						<small>{lang}wcf.acp.award.action.relevance.description{/lang}</small>
					</dd>
				</dl>
				<dl>
					<dt></dt>
					<dd>
						<label><input type="checkbox" name="isDisabled" value="1"{if !$award[isDisabled]} checked="checked"{/if} /> {lang}wcf.acp.award.action.isActive{/lang}</label>
						<small>{lang}wcf.acp.award.action.isActive.description{/lang}</small>
					</dd>
				</dl>
			</fieldset>
			
			<fieldset>
				<legend>{lang}wcf.acp.award.action.tiers{/lang}</legend>
				<dl>
					<dt><label for="parentID">{lang}wcf.acp.award.action.previousTier{/lang}</label></dt>
					<dd>
						<select name="parentID" id="parentID">
							<option value="0">{lang}wcf.global.noSelection{/lang}</option>
							{foreach from=$awards item=awardItem}
								<option value="{@$awardItem[awardID]}"{if $awardItem[awardID] == $award[parentID]} selected="selected"{/if}>{$awardItem[title]}</option>
							{/foreach}
						</select>
					{*if $errorField == 'awardDescription'*}
						<!--<small class="innerError">
							{*if $errorType == 'empty'*}
								{lang}wcf.global.form.error.empty{/lang}
							{*/if*}
						</small>-->
					{*/if*}
					</dd>
				</dl>
				<dl>
					<dt><label for="tier">{lang}wcf.acp.award.action.thisTier{/lang}</label></dt>
					<dd>
						<input type="number" id="tier" name="tier" value="{if $award[tier]}{@$award[tier]}{else}1{/if}" class="tiny" min="0" />
						<small>{lang}wcf.acp.award.action.thisTier.description{/lang}</small>
					</dd>
				</dl>
			</fieldset>
			
			<fieldset>
				<legend>{lang}wcf.acp.award.action.images{/lang}</legend>
				<dl>
					<dt><label for="ribbon">{lang}wcf.acp.award.action.ribbon{/lang}</label></dt>
					<dd>
						<input id="ribbon" name="ribbon" value="{if $award[ribbon]}{$award[ribbon]}{/if}" type="text" class="long" />
						{if $award[ribbon]}<small>{lang}wcf.acp.award.action.images.preview{/lang}: <img src="{$award[ribbon]}" alt="{$award[awardName]}"></small>{/if}
					{*if $errorField == 'awardDescription'*}
						<!--<small class="innerError">
							{*if $errorType == 'empty'*}
								{lang}wcf.global.form.error.empty{/lang}
							{*/if*}
						</small>-->
					{*/if*}
					</dd>
				</dl>
				<dl>
					<dt><label for="award">{lang}wcf.acp.award.action.award{/lang}</label></dt>
					<dd>
						<input id="award" name="award" value="{if $award[award]}{$award[award]}{/if}" type="text" class="long" />
						{if $award[award]}<small>{lang}wcf.acp.award.action.images.preview{/lang}: <img src="{$award[award]}" alt="{$award[awardName]}"></small>{/if}
					{*if $errorField == 'awardDescription'*}
						<!--<small class="innerError">
							{*if $errorType == 'empty'*}
								{lang}wcf.global.form.error.empty{/lang}
							{*/if*}
						</small>-->
					{*/if*}
					</dd>
				</dl>
			</fieldset>
			
			<div class="formSubmit">
				<input type="submit" value="{lang}wcf.global.button.submit{/lang}" accesskey="s" />
				{@SECURITY_TOKEN_INPUT_TAG}
			</div>
		  
			{event name='fieldsets'}
		</form>
	</div>
		
	{if $action == 'edit'}
		<div id="issue" class="container containerPadding tabMenuContent">
			<form method="post" action="{link controller='awardActionEdit'}{/link}">
				<fieldset class="marginBottom">
					<legend>{lang}wcf.acp.award.action.issue.new{/lang}</legend>
					<dl>
						<dt><label for="issueUsername">{lang}wcf.user.username{/lang}</label></dt>
						<dd>
							<input id="issueUsername" name="issueUsername" value="{if $issued|isset}{$issued[username]}{/if}" type="text" class="medium" />
						</dd>
					</dl>
					<dl>
						<dt><label for="issueUsername">{lang}wcf.acp.award.action.reason{/lang}</label></dt>
						<dd>
							<textarea id="issueReason" name="issueReason" cols="40" rows="5">{if $issued|isset}{$issued[description]}{/if}</textarea>
						</dd>
					</dl>
					
					<div class="formSubmit">
						<input type="submit" value="{lang}wcf.global.button.submit{/lang}" accesskey="s" />
						{@SECURITY_TOKEN_INPUT_TAG}
					</div>
					
				</fieldset>
			</form>
			
			{if $issuedAwards|count}
				<div class="tabularBox tabularBoxTitle marginTop">
					<header>
						<h2>{lang}wcf.acp.award.action.issued.list{/lang} <span class="badge badgeInverse">{#$issuedAwards|count}</span></h2>
					</header>
					
					<table class="table">
						<thead>
							<tr>
								<th class="columnTime" colspan="2"><a>{lang}wcf.acp.award.action.issueTime{/lang}</a></th>
								<th class="columnUser"><a>{lang}wcf.user.username{/lang}</a></th>
								<th class="columnReason"><a>{lang}wcf.acp.award.action.reason{/lang}</a></th>

								{event name='columnHeads'}
							</tr>
						</thead>
						
						<tbody>
							{foreach from=$issuedAwards item=issue}
								<tr class="jsAwardActionRow">
									<td class="columnIcon">
										<a href="{link controller='AwardActionEdit' id=$award[awardID] issueID=$issue[issueID]}{/link}" title="{lang}wcf.global.button.edit{/lang}" class="jsTooltip"><span class="icon icon16 icon-pencil"></span></a>

										{if true}
											<span class="icon icon16 icon-remove disabled" title="{lang}wcf.global.button.delete{/lang}"></span>
										{else}
											<span class="icon icon16 icon-remove jsDeleteButton jsTooltip pointer" title="{lang}wcf.global.button.delete{/lang}" data-object-id="{@$issue[awardID]}" data-confirm-message="{lang}wcf.acp.award.action.list.sureDelete{/lang}"></span>
										{/if}
					
										{event name='rowButtons'}
									</td>
									<td class="columnTitle">{$issue[time]|date}</td>
									<td class="columnCategory">{$issue[username]}</td>
									<td class="columnRibbon" style="width:50%;">{$issue[description]}</td>

									{event name='columns'}
								</tr>
							{/foreach}
						</tbody>
					</table>
					
				</div>
			{else}
				<p class="info">{lang}wcf.acp.award.noItems{/lang}</p>
			{/if}
		</div>
	{/if}
</div>

{include file='footer'}
