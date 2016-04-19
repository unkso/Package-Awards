{include file='documentHeader'}
<head>
    <title>{lang}wcf.page.awards.title{/lang} - {PAGE_TITLE|language}</title>

    {include file='headInclude' sandbox=false}
</head>

<body id="tpl{$templateName|ucfirst}">
{include file='header'}

<header class="boxHeadline">
    <h1>{lang}wcf.page.awards.title{/lang}</h1>
</header>

{include file='userNotice'}

<div class="container marginTop">
    <ul class="containerList awardList">
        <li class="awardBox">
            <div>
                <div class="containerHeadline">
                    <h3>Test</h3>

                    {if $awards|count}
                        <table>
                            <tbody>
                            {foreach from=$awards item=award}
                                <tr class="jsAwardActionRow">
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
                    {else}
                        <p class="info">{lang}wcf.global.noItems{/lang}</p>
                    {/if}
                </div>
            </div>
        </li>
    </ul>
</div>

{include file='footer'}
</body>
</html>