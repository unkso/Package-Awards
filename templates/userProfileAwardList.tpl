{* include file='__commentJavaScript' commentContainerID='userProfileAwardList' *}

{hascontent}
    <ul id="userProfileAwardList" class="awardList containerList" data-object-id="{@$userID}">
        {content}
            Awards for: {@$userID}
        {/content}
    </ul>
{hascontentelse}
    <div class="containerPadding">
        {lang}wcf.user.profile.content.wall.noEntries{/lang}
    </div>
{/hascontent}