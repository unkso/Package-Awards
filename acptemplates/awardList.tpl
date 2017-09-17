{include file='header' pageTitle='wcf.acp.award.action.list'}

<header class="boxHeadline">
	<h1>{lang}wcf.acp.award.action.list{/lang}</h1>
	
	<script data-relocate="true">
		//<![CDATA[
		$(function() {
			new WCF.Action.Delete('wcf\\data\\award\\action\\AwardAction', '.jsAwardActionRow .jsDeleteButton');
		});

		{event name='afterJavascriptInitialization'}
		//]]>
	</script>

</header>

<div class="contentNavigation">
	{pages print=true assign=pagesLinks controller="AwardList" link="pageNo=%d&sortField=$sortField&sortOrder=$sortOrder"}
	
	<nav>
		<ul>
			<li><a href="{link controller='AwardAdd'}{/link}" class="button"><span class="icon icon16 icon-plus"></span> <span>{lang}wcf.acp.award.action.add{/lang}</span></a></li>
			
			{event name='contentNavigationButtonsTop'}
		</ul>
	</nav>
</div>

{if $objects|count}
	<div class="tabularBox tabularBoxTitle marginTop">
		<header>
			<h2>{lang}wcf.acp.award.action.list{/lang} <span class="badge badgeInverse">{#$items}</span></h2>
		</header>
		
		<table class="table">
			<thead>
				<tr>
					<th class="columnID{if $sortField == 'awardID'} active {@$sortOrder}{/if}" colspan="2"><a href="{link controller='AwardList'}pageNo={@$pageNo}&sortField=awardID&sortOrder={if $sortField == 'awardID' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.global.objectID{/lang}</a></th>
					<th class="columnTitle{if $sortField == 'title'} active {@$sortOrder}{/if}"><a href="{link controller='AwardList'}pageNo={@$pageNo}&sortField=title&sortOrder={if $sortField == 'title' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.acp.award.action.name{/lang}</a></th>
					<th class="columnCategory{if $sortField == 'categoryID'} active {@$sortOrder}{/if}"><a href="{link controller='AwardList'}pageNo={@$pageNo}&sortField=categoryID&sortOrder={if $sortField == 'categoryID' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.acp.award.action.category{/lang}</a></th>
					<th class="columnRibbon"><a>{lang}wcf.acp.award.action.ribbon{/lang}</a></th>
					<th class="columnRelevance{if $sortField == 'relevance'} active {@$sortOrder}{/if}"><a href="{link controller='AwardList'}pageNo={@$pageNo}&sortField=relevance&sortOrder={if $sortField == 'relevance' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.acp.award.action.relevance{/lang}</a></th>

					{event name='columnHeads'}
				</tr>
			</thead>
			
			<tbody>
				{foreach from=$objects item=award}
					<tr class="jsAwardActionRow">
						<td class="columnIcon">
							<a href="{link controller='AwardEdit' id=$award->awardID}{/link}" title="{lang}wcf.global.button.edit{/lang}" class="jsTooltip"><span class="icon icon16 icon-pencil"></span></a>
							<span class="icon icon16 icon-remove jsDeleteButton jsTooltip pointer" title="{lang}wcf.global.button.delete{/lang}" data-object-id="{@$award->awardID}" data-confirm-message="{lang}wcf.acp.clan.award.delete.sure{/lang}"></span>

							{event name='rowButtons'}
						</td>
						<td class="columnID">{$award->awardID}</td>
						<td class="columnTitle">{$award->title}</td>
						<td class="columnCategory">{$award->getCategory()->getTitle()}</td>
						<td class="columnRibbon"><img src="{$award->getRibbonURL()}" alt="{$award->title}"></td>
						<td class="columnRelevance">{#$award->sortOrder}</td>

						{event name='columns'}
					</tr>
				{/foreach}
			</tbody>
		</table>
		
	</div>
	
	<div class="contentNavigation">
		{@$pagesLinks}
		
		<nav>
			<ul>
				<li><a href="{link controller='AwardAdd'}{/link}" class="button"><span class="icon icon16 icon-plus"></span> <span>{lang}wcf.acp.award.action.add{/lang}</span></a></li>
				
				{event name='contentNavigationButtonsBottom'}
			</ul>
		</nav>
	</div>
{else}
	<p class="info">{lang}wcf.global.noItems{/lang}</p>
{/if}

{include file='footer'}
