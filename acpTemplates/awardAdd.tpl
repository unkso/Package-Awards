{include file='header' pageTitle='wcf.acp.award.action.'|concat:$action}

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
			<dl>
				<dt><label for="parentID">{lang}wcf.acp.award.action.previousTier{/lang}</label></dt>
				<dd>
					<select name="parentID" id="previousTierID">
						<option value="0">{lang}wcf.global.noSelection{/lang}</option>
						{foreach from=$awardList item=award}
							<option value="{@$award->awardID}"{if $award->awardID == $previousTierID} selected="selected"{/if}>{$award->title}</option>
						{/foreach}
					</select>
					{if $errorField == 'previousTierID'}
						<small class="innerError">
							{lang}wcf.global.form.error.{$errorType}{/lang}
						</small>
					{/if}
				</dd>
			</dl>
			<dl>
				<dt><label for="tier">{lang}wcf.acp.award.action.thisTier{/lang}</label></dt>
				<dd>
					<input type="number" id="tier" name="tier" value="{if $tier|or:$object->tier}{$tier|or:$object->isDisabled}{else}1{/if}" class="tiny" min="0" />
					<small>{lang}wcf.acp.award.action.thisTier.description{/lang}</small>
				</dd>
			</dl>
		</fieldset>

		<fieldset>
			<legend>{lang}wcf.acp.award.action.images{/lang}</legend>
			<dl>
				<dt><label for="ribbon">{lang}wcf.acp.award.action.ribbon{/lang}</label></dt>
				<dd>
					<input id="ribbon" name="ribbonURL" value="{$ribbonURL|or:$object->ribbonURL}" type="text" class="long" />
					{if $object && $object->ribbonURL}<small>{lang}wcf.acp.award.action.images.preview{/lang}: <img src="{$object->ribbonURL}" alt="{$object->ribbonURL}"></small>{/if}
					{if $errorField == 'ribbonURL'}
						<small class="innerError">
							{lang}wcf.global.form.error.{$errorType}{/lang}
						</small>
					{/if}
				</dd>
			</dl>
			<dl>
				<dt><label for="award">{lang}wcf.acp.award.action.award{/lang}</label></dt>
				<dd>
					<input id="award" name="awardURL" value="{$awardURL|or:$object->awardURL}" type="text" class="long" />
					{if $object && $object->awardURL}<small>{lang}wcf.acp.award.action.images.preview{/lang}: <img src="{$object->awardURL}" alt="{$object->title}"></small>{/if}
					{if $errorField == 'awardURL'}
						<small class="innerError">
							{lang}wcf.global.form.error.{$errorType}{/lang}
						</small>
					{/if}
				</dd>
			</dl>
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
