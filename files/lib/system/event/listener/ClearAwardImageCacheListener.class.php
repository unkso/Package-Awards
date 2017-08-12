<?php

namespace wcf\system\event\listener;

class ClearAwardImageCacheListener implements IParameterizedEventListener
{
    /**
     * @inheritDoc
     */
    public function execute($eventObj, $className, $eventName, array &$parameters)
    {
        $cachePath = WBB_DIR . 'wcf/cache/ranks/*';
        $files = glob($cachePath);

        foreach ($files as $file) {
            if (is_file($file)) {
                unlink($file);
            }
        }

    }
}