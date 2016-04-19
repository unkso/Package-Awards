{include file='header' pageTitle='wcf.acp.award.action.list'}

<header class="boxHeadline">
	<h1>{lang}wcf.acp.award.action.list{/lang}</h1>
	
	<script data-relocate="true">
		//<![CDATA[
		$(function() {
			new WCF.Action.Delete('wcf\\data\\award\\action\\AwardAction', '.jsAwardActionRow');
		});
		//]]>
	</script>

</header>

<div class="contentNavigation">
	{pages print=true assign=pagesLinks controller="AwardActionList" link="pageNo=%d&sortField=$sortField&sortOrder=$sortOrder"}
	
	<nav>
		<ul>
			<li><a href="{link controller='AwardActionAdd'}{/link}" class="button"><span class="icon icon16 icon-plus"></span> <span>{lang}wcf.acp.award.action.add{/lang}</span></a></li>
			
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
					<th class="columnID{if $sortField == 'awardID'} active {@$sortOrder}{/if}" colspan="2"><a href="{link controller='AwardActionList'}pageNo={@$pageNo}&sortField=awardID&sortOrder={if $sortField == 'awardID' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.global.objectID{/lang}</a></th>
					<th class="columnTitle{if $sortField == 'title'} active {@$sortOrder}{/if}"><a href="{link controller='AwardActionList'}pageNo={@$pageNo}&sortField=title&sortOrder={if $sortField == 'title' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.acp.award.action.name{/lang}</a></th>
					<th class="columnCategory{if $sortField == 'category'} active {@$sortOrder}{/if}"><a href="{link controller='AwardActionList'}pageNo={@$pageNo}&sortField=category&sortOrder={if $sortField == 'category' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.acp.award.action.category{/lang}</a></th>
					<th class="columnRibbon"><a href="{link controller='AwardActionList'}pageNo={@$pageNo}{/link}">{lang}wcf.acp.award.action.ribbon{/lang}</a></th>
					<th class="columnDescription"><a href="{link controller='AwardActionList'}pageNo={@$pageNo}&sortField=description&sortOrder={if $sortField == 'description' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.acp.award.action.description{/lang}</a></th>
					<th class="columnRelevance{if $sortField == 'relevance'} active {@$sortOrder}{/if}"><a href="{link controller='AwardActionList'}pageNo={@$pageNo}&sortField=relevance&sortOrder={if $sortField == 'relevance' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.acp.award.action.relevance{/lang}</a></th>
					<th class="columnIssued{if $sortField == 'description'} active {@$sortOrder}{/if}"><a href="{link controller='AwardActionList'}pageNo={@$pageNo}&sortField=description&sortOrder={if $sortField == 'description' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.acp.award.action.issued{/lang}</a></th>

					{event name='columnHeads'}
				</tr>
			</thead>
			
			<tbody>
				{foreach from=$awards item=award}
					<tr class="jsAwardActionRow">
						<td class="columnIcon">
							<a href="{link controller='AwardActionEdit' id=$award[awardID] type=issue}{/link}" title="{lang}wcf.global.button.edit{/lang}" class="jsTooltip"><span class="icon icon16 icon-pencil"></span></a>

							{if true}
								<span class="icon icon16 icon-remove disabled" title="{lang}wcf.global.button.delete{/lang}"></span>
							{else}
								<span class="icon icon16 icon-remove jsDeleteButton jsTooltip pointer" title="{lang}wcf.global.button.delete{/lang}" data-object-id="{@$award[awardID]}" data-confirm-message="{lang}wcf.acp.award.action.list.sureDelete{/lang}"></span>
							{/if}
		
							{event name='rowButtons'}
						</td>
						<td class="columnID">{$award[awardID]}</td>
						<td class="columnTitle">{$award[title]}</td>
            			<td class="columnCategory">{$award[category]}</td>
            			<td class="columnRibbon"><img src="{$award[ribbonURL]}" alt="{$award[title]}"></td>
            			<td class="columnDescription">{$award[description]}</td>
            			<td class="columnRelevance">{#$award[relevance]}</td>
            			<td class="columnIssued">{#$award[issued]}</td>

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
				<li><a href="{link controller='AwardActionAdd'}{/link}" class="button"><span class="icon icon16 icon-plus"></span> <span>{lang}wcf.acp.award.action.add{/lang}</span></a></li>
				
				{event name='contentNavigationButtonsBottom'}
			</ul>
		</nav>
	</div>
{else}
	<p class="info">{lang}wcf.global.noItems{/lang}</p>
{/if}

{include file='footer'}
