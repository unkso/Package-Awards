{include file='header' pageTitle='wcf.acp.award.action.'|concat:$action}

<script data-relocate="true">
	//<![CDATA[
	$(function() {
		WCF.TabMenu.init();

		$("#tierTabList").on("click", "#addTier", function() {
			var template = $("#new-tier-template").clone();

			var key = 0;
			while ($("#tier-" + key).length) {
				key++;
			}

			// Add block element
			template.attr('id', 'tier-' + key);
			template.css('display', 'block');
			template.html(template.html().replace(/-replace-/g, key));
			$("#tiers").append(template);

			// Add tab
			var tab = $("#new-tier-tab-template").clone();
			tab.attr('id', 'tier-' + key);
			tab.css('display', 'inline-block');
			tab.html(tab.html().replace(/-replace-/g, 'tier-' + key));
			tab.insertBefore("#tierTabList li:last-child");

			WCF.TabMenu.reload();
			$("#tierTabList").tabs().tabs('refresh');
		});
	});
	//]]>
</script>

<header class="boxHeadline">
	<h1>{lang}wcf.acp.award.action.{$action}{/lang}</h1>
</header>

{include file='formError'}

{if $success|isset}
	<p class="success">{lang}wcf.global.success.{$action}{/lang}</p>
{/if}

<div class="contentNavigation">
	<nav>
		<ul>
			<li><a href="{link controller='AwardList'}{/link}" class="button"><span class="icon icon16 icon-list"></span> <span>{lang}wcf.acp.menu.link.clan.award.list{/lang}</span></a></li>

			{event name='contentNavigationButtons'}
		</ul>
	</nav>
</div>

<form method="post" action="{if $action == 'add'}{link controller='AwardAdd'}{/link}{else}{link controller='AwardEdit' id=$primaryID}{/link}{/if}">
	<div class="container containerPadding marginTop">
		<fieldset>
			<legend>{lang}wcf.acp.award.action.general{/lang}</legend>
			<dl>
				<dt><label for="awardName">{lang}wcf.acp.award.action.name{/lang}</label></dt>
				<dd>
					<input id="title" name="title" value="{$title|or:$object->title}" type="text" class="medium" />
					{if $errorField == 'title'}
						<small class="innerError">
							{lang}wcf.global.form.error.{$errorType}{/lang}
						</small>
					{/if}
				</dd>
			</dl>
			<dl>
				<dt><label for="awardCategory">{lang}wcf.acp.award.action.category{/lang}</label></dt>
				<dd>
					<select name="categoryID" id="categoryID">
						{assign var=selectedCategory value=$categoryID|or:$object->categoryID}
						{foreach from=$categoryList item=category}
							<option value="{@$category->categoryID}"{if $category->categoryID == $selectedCategory} selected="selected"{/if}>{$category->title}</option>
						{/foreach}
					</select>
					<small>{lang}wcf.acp.award.action.category.description{/lang}</small>
					{if $errorField == 'categoryID'}
						<small class="innerError">
							{lang}wcf.global.form.error.{$errorType}{/lang}
						</small>
					{/if}
				</dd>
			</dl>
			<dl>
				<dt><label for="awardDescription">{lang}wcf.acp.award.action.description{/lang}</label></dt>
				<dd>
					<textarea id="awardDescription" name="description" cols="40" rows="5">{$description|or:$object->description}</textarea>
					{if $errorField == 'description'}
						<small class="innerError">
							{lang}wcf.global.form.error.{$errorType}{/lang}
						</small>
					{/if}
				</dd>
			</dl>
			<dl>
				<dt><label for="relevance">{lang}wcf.acp.award.action.relevance{/lang}</label></dt>
				<dd>
					<input type="number" id="relevance" name="relevance" value="{if $relevance|or:$object->title}{$relevance|or:$object->title}{else}1{/if}" class="tiny" min="0" />
					<small>{lang}wcf.acp.award.action.relevance.description{/lang}</small>
					{if $errorField == 'relevance'}
						<small class="innerError">
							{lang}wcf.global.form.error.{$errorType}{/lang}
						</small>
					{/if}
				</dd>
			</dl>
			<dl>
				<dt></dt>
				<dd>
					{assign var=disabled value=$isDisabled|or:$object->isDisabled}
					<label><input type="checkbox" name="isDisabled" value="1"{if !$disabled} checked="checked"{/if} /> {lang}wcf.acp.award.action.isActive{/lang}</label>
					<small>{lang}wcf.acp.award.action.isActive.description{/lang}</small>
					{if $errorField == 'isDisabled'}
						<small class="innerError">
							{lang}wcf.global.form.error.{$errorType}{/lang}
						</small>
					{/if}
				</dd>
			</dl>
		</fieldset>

		<fieldset>
			<legend>{lang}wcf.acp.award.action.tiers{/lang}</legend>

			<div id="tiers" class="tabMenuContainer" data-active="{$activeTabMenuItem}" data-store="activeTabMenuItem">
				<nav class="tabMenu">
					<ul id="tierTabList">
						{if $action == 'edit'}
							{foreach from=$object->getTiers() item=tier key=key}
								<li><a href="{@$__wcf->getAnchor('tier-')|concat:$key}">ABC</a></li>
							{/foreach}
							<li id="addTier"><i class="icon icon16 icon-plus"></i></li>
						{else}
							<li><a href="{@$__wcf->getAnchor('first-tier')}">Main Tier</a></li>
							<li id="addTier"><a><i class="icon icon16 icon-plus"></i></a></li>
						{/if}
					</ul>
				</nav>

				{if $action == 'edit'}
					{foreach from=$object->getTiers() item=tier key=key}
						<div id="tier-{$key}" class="container containerPadding tabMenuContainer tabMenuContent">
							{include file='awardTierInformation' suffix=$key tier=$tier}
						</div>
					{/foreach}
				{else}
					<div id="first-tier" class="container containerPadding tabMenuContainer tabMenuContent">
						{include file='awardTierInformation' suffix='new'}
					</div>
				{/if}

				<!-- Templates for Tier list -->
				<div id="new-tier-template" class="container containerPadding tabMenuContainer tabMenuContent" style="display:none;">
					{include file='awardTierInformation' suffix='-replace-'}
				</div>
				<li id="new-tier-tab-template" style="display:none;"><a href="{@$__wcf->getAnchor('-replace-')}">Main Tier</a></li>
				<!-- Templates for Tier list -->

			</div>
		</fieldset>

		<div class="formSubmit">
			<input type="submit" value="{lang}wcf.global.button.submit{/lang}" accesskey="s" />
			{@SECURITY_TOKEN_INPUT_TAG}
		</div>
		{$errorField} {$errorType}
		{event name='fieldsets'}
	</div>
</form>

{include file='footer'}
