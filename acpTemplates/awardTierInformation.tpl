<fieldset>
    <input type="hidden" name="tierID[]" value="{if $tier|isset}{$tier->tierID}{else}-1{/if}">

    {if $award|isset}
        <dl>
            <dt>Final name</dt>
            <dd>
                {$award->title|concat:$tier->levelSuffix}
            </dd>
        </dl>
    {/if}

    <dl>
        <dt><label for="suffix-{$suffix}">Suffix</label></dt>
        <dd>
            <input type="text" id="suffix-{$suffix}" name="suffix[]" value="{if $tier|isset}{$tier->levelSuffix}{/if}" class="tiny"	/>
            <small>This is the suffix for displaying the award with this tier. e.g. ("[1]" will be displayed as "Award Name [1]")</small>
            {if $errorField == 'suffix'}
                <small class="innerError">
                    {lang}wcf.global.form.error.{$errorType}{/lang}
                </small>
            {/if}
        </dd>
    </dl>

    <dl>
        <dt><label for="level-{$suffix}">Level</label></dt>
        <dd>
            <input type="number" id="level-{$suffix}" name="level[]" value="{if $tier|isset}{$tier->level}{/if}" class="tiny" min="0"/>
            <small>Members must first have an award with a lower tier level before getting this one</small>
            {if $errorField == 'level'}
                <small class="innerError">
                    {lang}wcf.global.form.error.{$errorType}{/lang}
                </small>
            {/if}
        </dd>
    </dl>

    <dl>
        <dt><label for="description-{$suffix}">Description</label></dt>
        <dd>
            <textarea id="description-{$suffix}" name="tierDescription[]" cols="40" rows="5">{if $tier|isset}{$tier->description}{/if}</textarea>
            {if $errorField == 'tierDescription'}
                <small class="innerError">
                    {lang}wcf.global.form.error.{$errorType}{/lang}
                </small>
            {/if}
        </dd>
    </dl>

    <dl>
        <dt><label for="ribbonURL-{$suffix}">Ribbon URL</label></dt>
        <dd>
            <input id="ribbonURL-{$suffix}" name="ribbonURL[]" value="{if $tier|isset}{$tier->ribbonURL}{/if}" type="text" class="medium" />
            {if $errorField == 'ribbonURL'}
                <small class="innerError">
                    {lang}wcf.global.form.error.{$errorType}{/lang}
                </small>
            {/if}

            {if $tier|isset}
                <small>Preview:</small>
                <img src="{$tier->ribbonURL}">
            {/if}
        </dd>
    </dl>
</fieldset>