{include file='documentHeader'}
<head>
    <title>{lang}wcf.page.awards.title{/lang} - {PAGE_TITLE|language}</title>

    {include file='headInclude' sandbox=false}
</head>

<body id="tpl{$templateName|ucfirst}">
{include file='header' title='wcf.page.awards.title'|language paddingBottom=30 light=true}

{include file='userNotice'}

<div class="container marginTop">

    <div class="row marginTop">
        <div class="col-md-4">
            <div class="tabs tabs-vertical tabs-left tabs-navigation">
                <ul class="nav nav-tabs col-sm-3">
                    {foreach from=$awards item=category key=key}
                        {counter assign=tabNo name=tabNo print=false}
                        <li {if $tabNo == 1}class="active"{/if}>
                            <a href="#tabCategory{$key}" data-toggle="tab">{$category['title']}</a>
                        </li>
                    {/foreach}
                </ul>
            </div>
        </div>

        <div class="col-md-8">
            {foreach from=$awards item=category key=key}
                {counter assign=paneNo name=paneNo print=false}

                <div class="tab-pane tab-pane-navigation {if $paneNo == 1}active{/if}" id="tabCategory{$key}">
                    {if $category['awards']|count}
                        {foreach from=$category['awards'] item=award}
                            <div class="col-md-4">
                                <p>
                                    <img src="{$award->awardURL}">
                                </p>
                                <p>
                                    {$award->title}
                                </p>
                            </div>
                        {/foreach}
                    {else}
                        <div class="alert alert-warning">
                            <strong>Ouch!</strong> We don't currently have any publicly visible awards in this category. Sorry about that.
                        </div>
                    {/if}
                </div>
            {/foreach}
        </div>
    </div>

</div>

{include file='footer' skipBreadcrumbs=true}
</body>
</html>