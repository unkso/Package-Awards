{include file='header' pageTitle='wcf.acp.award.action.'|concat:$action}

<script data-relocate="true">
    WCF.Search.Award = WCF.Search.Base.extend({
        _className: 'wcf\\data\\award\\action\\AwardAction'
    });

    //<![CDATA[
    $(function() {
        new WCF.Search.Award("#replacesAward", null, false);
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

<form method="post" action="{if $action == 'add'}{link controller='AwardAdd'}{/link}{else}{link controller='AwardEdit' id=$awardID}{/link}{/if}">
	<div class="container containerPadding marginTop">
		<fieldset>
			<legend>{lang}wcf.acp.award.action.general{/lang}</legend>
			<dl>
				<dt><label for="title">{lang}wcf.acp.award.action.name{/lang}</label></dt>
				<dd>
					<input id="title" name="title" value="{$title}" type="text" class="medium" />
					{if $errorField == 'title'}
						<small class="innerError">
							{lang}wcf.global.form.error.{$errorType}{/lang}
						</small>
					{/if}
				</dd>
			</dl>
			<dl>
				<dt><label for="description">{lang}wcf.acp.award.action.description{/lang}</label></dt>
				<dd>
					<textarea id="description" name="description" cols="40" rows="5">{$description}</textarea>
                    {if $errorField == 'description'}
						<small class="innerError">
                            {lang}wcf.global.form.error.{$errorType}{/lang}
						</small>
                    {/if}
				</dd>
			</dl>
			<dl>
				<dt><label for="requirements">{lang}wcf.acp.award.action.requirements{/lang}</label></dt>
				<dd>
					<textarea id="requirements" name="requirements" cols="40" rows="5">{$requirements}</textarea>
                    {if $errorField == 'requirements'}
						<small class="innerError">
                            {lang}wcf.global.form.error.{$errorType}{/lang}
						</small>
                    {/if}
				</dd>
			</dl>
			<dl>
				<dt><label for="categoryID">{lang}wcf.acp.award.action.category{/lang}</label></dt>
				<dd>
					<select name="categoryID" id="categoryID">
						{foreach from=$categoryList item=category}
							<option value="{@$category->categoryID}"{if $category->categoryID == $categoryID} selected="selected"{/if}>{$category->title}</option>
						{/foreach}
					</select>
					{if $errorField == 'categoryID'}
						<small class="innerError">
							{lang}wcf.global.form.error.{$errorType}{/lang}
						</small>
					{/if}
				</dd>
			</dl>
			<dl>
				<dt><label for="sortOrder">{lang}wcf.acp.award.action.sortOrder{/lang}</label></dt>
				<dd>
					<input type="number" id="sortOrder" name="sortOrder" value="{$sortOrder}" class="tiny" min="0" />
					<small>{lang}wcf.acp.award.action.sortOrder.description{/lang}</small>
					{if $errorField == 'sortOrder'}
						<small class="innerError">
							{lang}wcf.global.form.error.{$errorType}{/lang}
						</small>
					{/if}
				</dd>
			</dl>
		</fieldset>

		<fieldset>
			<legend>{lang}wcf.acp.award.action.images{/lang}</legend>
			<dl>
				<dt><label for="medalURL">{lang}wcf.acp.award.action.medal{/lang}</label></dt>
				<dd>
					<input id="medalURL" name="medalURL" value="{$medalURL}" type="text" class="medium" />
                    {if $errorField == 'awardURL'}
						<small class="innerError">
                            {lang}wcf.global.form.error.{$errorType}{/lang}
						</small>
                    {/if}
				</dd>
			</dl>
			<dl>
				<dt><label for="ribbonURL">{lang}wcf.acp.award.action.ribbon{/lang}</label></dt>
				<dd>
					<input id="ribbonURL" name="ribbonURL" value="{$ribbonURL}" type="text" class="medium" />
                    {if $errorField == 'ribbonURL'}
						<small class="innerError">
                            {lang}wcf.global.form.error.{$errorType}{/lang}
						</small>
                    {/if}
				</dd>
			</dl>
		</fieldset>

		<fieldset>
			<legend>{lang}wcf.acp.award.action.settings{/lang}</legend>
			<dl>
				<dt></dt>
				<dd>
					<label><input type="checkbox" name="isTiered" value="1"{if $isTiered} checked="checked"{/if} /> {lang}wcf.acp.award.action.isTiered{/lang}</label>
				</dd>
			</dl>
			<dl>
				<dt><label for="replacesAward">{lang}wcf.acp.award.action.replacesAward{/lang}</label></dt>
				<dd>
					<input id="replacesAward" name="replacesAward" value="{$replacesAward}" type="text" class="medium" />
					<small>{lang}wcf.acp.award.action.replacesAward.description{/lang}</small>
                    {if $errorField == 'replacesAward'}
						<small class="innerError">
                            {if $errorType == 'notavailable'}
                                {lang}wcf.acp.award.action.error.replacesAward.notavailable{/lang}
                            {else}
                                {lang}wcf.global.form.error.{$errorType}{/lang}
                            {/if}
						</small>
                    {/if}
				</dd>
			</dl>
			<dl>
				<dt></dt>
				<dd>
					<label><input type="checkbox" name="isHidden" value="1"{if $isHidden} checked="checked"{/if} /> {lang}wcf.acp.award.action.isHidden{/lang}</label>
				</dd>
			</dl>
			<dl>
				<dt></dt>
				<dd>
					<label><input type="checkbox" name="isDisabled" value="1"{if $isDisabled} checked="checked"{/if} /> {lang}wcf.acp.award.action.isDisabled{/lang}</label>
					<small>{lang}wcf.acp.award.action.isDisabled.description{/lang}</small>
				</dd>
			</dl>
		</fieldset>

		<div class="formSubmit">
			<input type="submit" value="{lang}wcf.global.button.submit{/lang}" accesskey="s" />
			{@SECURITY_TOKEN_INPUT_TAG}
		</div>
		{event name='fieldsets'}
	</div>
</form>

{include file='footer'}