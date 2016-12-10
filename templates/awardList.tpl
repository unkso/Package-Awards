{include file='documentHeader'}
<head>
    <title>Awards Overview - {PAGE_TITLE|language}</title>

    {include file='headInclude' sandbox=false}
</head>

<body id="tpl{$templateName|ucfirst}">
    {include file='header' title='wcf.page.training.awards.title'|language light=true}

    <div class="container marginTop marginBottom-30">
        {include file='userNotice'}

        <div class="alert alert-info">
            This page lists only those awards, that can currently be recommended to users. Awards given out e.g. for MOS contribution and qualification are not listed.
        </div>

        <div class="row marginTop">
            <div class="col-md-4">
                <div class="tabs tabs-vertical tabs-left tabs-navigation">
                    <ul class="nav nav-tabs col-sm-3">
                        {foreach from=$awards item=category key=key}
                            {if !$category['disabled']}
                                {counter assign=tabNo name=tabNo print=false}
                                <li {if $tabNo == 1}class="active"{/if}>
                                    <a href="#tabCategory{$key}" data-toggle="tab">{$category['title']}</a>
                                </li>
                            {/if}
                        {/foreach}
                    </ul>
                </div>
            </div>

            <div class="col-md-8">
                {foreach from=$awards item=category key=key}
                    {if !$category['disabled']}
                        {counter assign=paneNo name=paneNo print=false}

                        <div class="tab-pane tab-pane-navigation {if $paneNo == 1}active{/if}" id="tabCategory{$key}">
                            {if $category['awards']|count}
                                <div class="row">
                                    {foreach from=$category['awards'] item=award}
                                        {if $award->awardURL}
                                            <div class="col-md-4 text-center">
                                                <p>
                                                    <a href="#award-{$award->awardID}" class="popup-with-zoom-anim"><img src="{$award->awardURL}" style="max-height:215px;"></a>
                                                </p>
                                                <p style="margin-top:5px;margin-bottom:30px;font-weight:600;">
                                                    {$award->title}
                                                </p>
                                            </div>

                                            <div id="award-{$award->awardID}" class="dialog dialog-md zoom-anim-dialog mfp-hide">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <img src="{$award->awardURL}" style="max-height:215px;margin-right:30px;">
                                                    </div>
                                                    <div class="col-md-8">
                                                        <h1>{$award->title}</h1>
                                                        <p>{$award->description}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        {/if}
                                    {/foreach}
                                </div>
                            {else}
                                <div class="alert alert-warning">
                                    <strong>Ouch!</strong> We don't currently have any publicly visible awards in this category. Sorry about that.
                                </div>
                            {/if}
                        </div>
                    {/if}
                {/foreach}
            </div>
        </div>

    </div>

    <script data-relocate="true">
        (function($){
            $('.popup-with-zoom-anim').magnificPopup({
                type: 'inline',

                fixedContentPos: false,
                fixedBgPos: true,

                overflowY: 'auto',

                closeBtnInside: true,
                preloader: false,

                midClick: true,
                removalDelay: 300,
                mainClass: 'my-mfp-zoom-in'
            });
        }).apply(this, [jQuery]);
    </script>
    {include file='footer' skipBreadcrumbs=true}
</body>
</html>