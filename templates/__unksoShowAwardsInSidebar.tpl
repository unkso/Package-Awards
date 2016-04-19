{award assign='awards' userID=$userProfile->userID}
{if $awards|count}
	<div class="userCredits">
		{foreach from=$awards item=award}
			<a href="#" class="jsTooltip" title="{$award[title]}">
				<img src='{$award[ribbon]}' alt='{$award[title]}'>
			</a>
		{/foreach}
	</div>
{/if}