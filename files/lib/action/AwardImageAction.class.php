<?php
namespace wcf\action;

use wcf\data\award\Award;
use wcf\data\award\AwardCache;

class AwardImageAction extends AbstractAction
{
    public $loginRequired = false;

    protected function tryServingCachedVersion()
    {
        $path = self::getCachedFilePath();
        if (!file_exists($path)) return false;

        $this->sendImageHeaders();
        echo readfile($path);

        return true;
    }

    protected static function getCachedFilePath()
    {
        $requestKeys = array_keys($_REQUEST);
        $path = str_replace(['award-image/', '_png'], '', $requestKeys[0]);
        $cacheDir = WBB_DIR . RELATIVE_WCF_DIR . 'cache/ranks/';

        return $cacheDir . str_replace('/', '-', $path);
    }

    public function execute()
    {
        if ($this->tryServingCachedVersion()) return;

        $requestKeys = array_keys($_REQUEST);
        $path = str_replace(['award-image/', '_png'], '', $requestKeys[0]);

        $parts = explode('/', $path);
        $type = $parts[0];
        $slug = $type == 'medal' ? $parts[1] : $parts[2];

        $awards = [];
        foreach (AwardCache::getInstance()->getAwards() as $award) {
            $awards[$award->getSlug()] = $award;
        }

        if (!isset($awards[$slug])) return;
        $award = $awards[$slug];

        $image = $this->getImage($award, $type);
        if ($type == 'ribbon') {
            $this->addDevices($image, $parts[1]);
        }

        $this->sendImageHeaders();
        imagepng($image);
        imagepng($image, self::getCachedFilePath()); // Cache the file
    }

    protected function sendImageHeaders()
    {
        $seconds_to_cache = 60 * 60 * 24 * 2; // 2 Days
        $ts = gmdate("D, d M Y H:i:s", time() + $seconds_to_cache) . " GMT";

        header_remove('Cache-Control'); // Override previously sent headers
        header("Expires: $ts");
        header("Cache-Control: max-age=$seconds_to_cache");
        header('Content-Type: image/png');
    }

    protected function addDevices($image, $number)
    {
        if ($number == 0) return;

        $path = WBB_DIR . RELATIVE_WCF_DIR . '/images/devices/';
        $bronzePath = $path . 'oakleaf_bronze.png';
        $silverPath = $path . 'oakleaf_silver.png';

        // Load oakleaf icons
        $bronzeImage = imagecreatefrompng($bronzePath);
        $silverImage = imagecreatefrompng($silverPath);

        // Set alpha channel for both
        imagealphablending($bronzeImage, true);
        imagesavealpha($bronzeImage, true);

        imagealphablending($silverImage, true);
        imagesavealpha($silverImage, true);

        // Calculate final sizes
        $height = imagesy($image);
        $width = imagesx($image);

        $bronzeWidth = imagesx($bronzeImage);
        $bronzeHeight = imagesy($bronzeImage);

        $silverWidth = imagesx($silverImage);
        $silverHeight = imagesy($silverImage);

        $bronzeFactor = ($height / 1.3) / $bronzeHeight;
        $silverFactor = ($height / 1.3) / $silverHeight;

        $bronzeResizedWidth = $bronzeFactor * $bronzeWidth;
        $silverResizedWidth = $silverFactor * $silverWidth;
        $bronzeResizedHeight = $bronzeFactor * $bronzeHeight;
        $silverResizedHeight = $silverFactor * $silverHeight;

        switch ($number) {
            case 1:
                // Centered bronze leaf
                imagecopyresized($image, $bronzeImage,
                    ceil($width / 2 - $bronzeResizedWidth / 2 + 1),
                    ceil($height / 2 - $bronzeResizedHeight / 2 + 1),
                    0, 0, $bronzeResizedWidth, $bronzeResizedHeight, $bronzeWidth, $bronzeHeight);
                break;
            case 2:
                // Left bronze leaf
                imagecopyresized($image, $bronzeImage,
                    ceil($width / 2 - $bronzeResizedWidth - 1),
                    ceil($height / 2 - $bronzeResizedHeight / 2) + 1,
                    0, 0, $bronzeResizedWidth, $bronzeResizedHeight, $bronzeWidth, $bronzeHeight);
                // Right bronze leaf
                imagecopyresized($image, $bronzeImage,
                    ceil($width / 2 + 3),
                    ceil($height / 2 - $bronzeResizedHeight / 2) + 1,
                    0, 0, $bronzeResizedWidth, $bronzeResizedHeight, $bronzeWidth, $bronzeHeight);
                break;
            case 3:
                // Centered bronze leaf
                imagecopyresized($image, $bronzeImage,
                    ceil($width / 2 - $bronzeResizedWidth / 2 + 1),
                    ceil($height / 2 - $bronzeResizedHeight / 2 + 1),
                    0, 0, $bronzeResizedWidth, $bronzeResizedHeight, $bronzeWidth, $bronzeHeight);
                // Left bronze leaf
                imagecopyresized($image, $bronzeImage,
                    ceil($width / 2 - $bronzeResizedWidth - 8),
                    ceil($height / 2 - $bronzeResizedHeight / 2) + 1,
                    0, 0, $bronzeResizedWidth, $bronzeResizedHeight, $bronzeWidth, $bronzeHeight);
                // Right bronze leaf
                imagecopyresized($image, $bronzeImage,
                    ceil($width / 2 + 10),
                    ceil($height / 2 - $bronzeResizedHeight / 2) + 1,
                    0, 0, $bronzeResizedWidth, $bronzeResizedHeight, $bronzeWidth, $bronzeHeight);
                break;
            case 4:
                // Bronze leaf 1
                imagecopyresized($image, $bronzeImage,
                    ceil($width / 2 - $bronzeResizedWidth - 16),
                    ceil($height / 2 - $bronzeResizedHeight / 2) + 1,
                    0, 0, $bronzeResizedWidth, $bronzeResizedHeight, $bronzeWidth, $bronzeHeight);
                // Bronze leaf 2
                imagecopyresized($image, $bronzeImage,
                    ceil($width / 2 - $bronzeResizedWidth + 1),
                    ceil($height / 2 - $bronzeResizedHeight / 2) + 1,
                    0, 0, $bronzeResizedWidth, $bronzeResizedHeight, $bronzeWidth, $bronzeHeight);
                // Bronze leaf 3
                imagecopyresized($image, $bronzeImage,
                    ceil($width / 2 + 1),
                    ceil($height / 2 - $bronzeResizedHeight / 2) + 1,
                    0, 0, $bronzeResizedWidth, $bronzeResizedHeight, $bronzeWidth, $bronzeHeight);
                // Bronze leaf 4
                imagecopyresized($image, $bronzeImage,
                    ceil($width / 2 + 18),
                    ceil($height / 2 - $bronzeResizedHeight / 2) + 1,
                    0, 0, $bronzeResizedWidth, $bronzeResizedHeight, $bronzeWidth, $bronzeHeight);
                break;
            case 5:
                // Centered silver leaf
                imagecopyresized($image, $silverImage,
                    ceil($width / 2 - $silverResizedWidth / 2 + 1),
                    ceil($height / 2 - $silverResizedHeight / 2 + 1),
                    0, 0, $silverResizedWidth, $silverResizedHeight, $silverWidth, $silverHeight);
                break;
            case 6:
                // Left silver leaf
                imagecopyresized($image, $silverImage,
                    ceil($width / 2 - $silverResizedWidth - 1),
                    ceil($height / 2 - $silverResizedHeight / 2) + 1,
                    0, 0, $silverResizedWidth, $silverResizedHeight, $silverWidth, $silverHeight);
                // Right bronze leaf
                imagecopyresized($image, $bronzeImage,
                    ceil($width / 2 + 3),
                    ceil($height / 2 - $bronzeResizedHeight / 2) + 1,
                    0, 0, $bronzeResizedWidth, $bronzeResizedHeight, $bronzeWidth, $bronzeHeight);
                break;
            case 7:
                // Centered bronze leaf
                imagecopyresized($image, $bronzeImage,
                    ceil($width / 2 - $bronzeResizedWidth / 2 + 1),
                    ceil($height / 2 - $bronzeResizedHeight / 2 + 1),
                    0, 0, $bronzeResizedWidth, $bronzeResizedHeight, $bronzeWidth, $bronzeHeight);
                // Left silver leaf
                imagecopyresized($image, $silverImage,
                    ceil($width / 2 - $silverResizedWidth - 8),
                    ceil($height / 2 - $silverResizedHeight / 2) + 1,
                    0, 0, $silverResizedWidth, $silverResizedHeight, $silverWidth, $silverHeight);
                // Right bronze leaf
                imagecopyresized($image, $bronzeImage,
                    ceil($width / 2 + 10),
                    ceil($height / 2 - $bronzeResizedHeight / 2) + 1,
                    0, 0, $bronzeResizedWidth, $bronzeResizedHeight, $bronzeWidth, $bronzeHeight);
                break;
            case 8:
                // Silver leaf 1
                imagecopyresized($image, $silverImage,
                    ceil($width / 2 - $silverResizedWidth - 16),
                    ceil($height / 2 - $silverResizedHeight / 2) + 1,
                    0, 0, $silverResizedWidth, $silverResizedHeight, $silverWidth, $silverHeight);
                // Bronze leaf 2
                imagecopyresized($image, $bronzeImage,
                    ceil($width / 2 - $bronzeResizedWidth + 1),
                    ceil($height / 2 - $bronzeResizedHeight / 2) + 1,
                    0, 0, $bronzeResizedWidth, $bronzeResizedHeight, $bronzeWidth, $bronzeHeight);
                // Bronze leaf 3
                imagecopyresized($image, $bronzeImage,
                    ceil($width / 2 + 1),
                    ceil($height / 2 - $bronzeResizedHeight / 2) + 1,
                    0, 0, $bronzeResizedWidth, $bronzeResizedHeight, $bronzeWidth, $bronzeHeight);
                // Bronze leaf 4
                imagecopyresized($image, $bronzeImage,
                    ceil($width / 2 + 18),
                    ceil($height / 2 - $bronzeResizedHeight / 2) + 1,
                    0, 0, $bronzeResizedWidth, $bronzeResizedHeight, $bronzeWidth, $bronzeHeight);
                break;
        }
    }

    protected function getImage(Award $award, $type)
    {
        $path = $type == 'medal' ? $award->getMedalPath() : $award->getRibbonPath();
        $info = pathinfo($path);

        switch (strtolower($info['extension'])) {
            case 'png':
                $image = imagecreatefrompng($path);
                imagealphablending($image, true);
                imagesavealpha($image, true);
                break;
            case 'jpg':
            case 'jpeg':
                $image = imagecreatefromjpeg($path);
                break;
            case 'gif':
                $image = imagecreatefromgif($path);
                imagealphablending($image, true);
                imagesavealpha($image, true);
                break;
        }

        return $image;
    }
}