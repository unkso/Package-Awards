{include file='header' pageTitle='wcf.acp.award.action.'|concat:$action}

<script data-relocate="true">
	//<![CDATA[
	$(function() {
		WCF.TabMenu.init();
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
					<input id="title" name="title" value="{$object->title|or:''}" type="text" class="medium" />
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
						{assign var=selectedCategory value=$object->categoryID}
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
					<textarea id="awardDescription" name="description" cols="40" rows="5">{$object->description|or:''}</textarea>
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
					<input type="number" id="relevance" name="relevance" value="{$object->relevance|or:1}" class="tiny" min="0" />
					<small>{lang}wcf.acp.award.action.relevance.description{/lang}</small>
					{if $errorField == 'relevance'}
						<small class="innerError">
							{lang}wcf.global.form.error.{$errorType}{/lang}
						</small>
					{/if}
				</dd>
			</dl>
            <dl>
                <dt><label for="awardURL">Award Image URL</label></dt>
                <dd>
                    <input id="awardURL" name="awardURL" value="{$object->awardURL|or:''}" type="text" class="medium" />
                    {if $errorField == 'awardURL'}
                        <small class="innerError">
                            {lang}wcf.global.form.error.{$errorType}{/lang}
                        </small>
                    {/if}
                </dd>
            </dl>
			<dl>
				<dt></dt>
				<dd>
					{assign var=disabled value=$object->isDisabled|or:'0'}
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

            {if $action == 'edit'}
                <nav>
                    <ul>
                        <li><a href="{link controller='AwardEdit' id=$primaryID newtier=true}{/link}#tier-new" class="button"><span class="icon icon16 icon-plus"></span> <span>Add additional tier</span></a></li>
                    </ul>
                </nav>
            {/if}

			<div id="tiers" class="tabMenuContainer" data-active="{$activeTabMenuItem}" data-store="activeTabMenuItem">
				{if $action == 'edit'}
					<nav class="tabMenu">
						<ul id="tierTabList">
								{foreach from=$object->getTiers() item=tier key=key}
									<li><a href="{@$__wcf->getAnchor('tier-')|concat:$key}">Tier {$tier->level}</a></li>
								{/foreach}

								{if $newTier}
									<li><a href="{@$__wcf->getAnchor('tier-new')}">New Tier</a></li>
								{/if}
						</ul>
					</nav>

					{foreach from=$object->getTiers() item=tier key=key}
						<div id="tier-{$key}" class="container containerPadding tabMenuContainer tabMenuContent">
							{include file='awardTierInformation' suffix=$key tier=$tier award=$object}
						</div>
					{/foreach}

					{if $newTier}
						<div id="tier-new" class="container containerPadding tabMenuContainer tabMenuContent">
							<div class="info">Your new tier has not been saved yet. Please fill in the necessary information and click Submit.</div>

							{include file='awardTierInformation' suffix='create-new' tier=null}
						</div>
					{/if}
				{else}
					<nav class="tabMenu">
						<ul id="tierTabList">
							<li><a href="{@$__wcf->getAnchor('first-tier')}">Main Tier</a></li>
						</ul>
					</nav>

					<div id="first-tier" class="container containerPadding tabMenuContainer tabMenuContent">
						{include file='awardTierInformation' suffix='first' tier=null}
					</div>
				{/if}
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