<?php namespace wcf\data\award\category;

use wcf\data\award\AwardCache;
use wcf\data\category\AbstractDecoratedCategory;
use wcf\data\ITraversableObject;
use wcf\system\exception\SystemException;
use wcf\system\WCF;

class AwardCategory extends AbstractDecoratedCategory implements \Countable, ITraversableObject
{
    protected $index = 0;

    protected $indexToObject = null;

    /**
     * list of assigned ranks
     * @var	array<\wcf\data\rank\Rank>
     */
    public $awards = null;

    /**
     * Loads associated ranks from cache.
     */
    public function loadRanks() {
        if ($this->awards === null) {
            $this->awards = AwardCache::getInstance()->getCategoryAwards($this->categoryID ?: null);
            $this->indexToObject = array_keys($this->awards);
        }
    }

    /**
     * @see	\Countable::count()
     */
    public function count() {
        return count($this->awards);
    }

    /**
     * @see	\Iterator::current()
     */
    public function current() {
        $objectID = $this->indexToObject[$this->index];
        return $this->awards[$objectID];
    }

    /**
     * CAUTION: This methods does not return the current iterator index,
     * rather than the object key which maps to that index.
     *
     * @see	\Iterator::key()
     */
    public function key() {
        return $this->indexToObject[$this->index];
    }

    /**
     * @see	\Iterator::next()
     */
    public function next() {
        ++$this->index;
    }

    /**
     * @see	\Iterator::rewind()
     */
    public function rewind() {
        $this->index = 0;
    }

    /**
     * @see	\Iterator::valid()
     */
    public function valid() {
        return isset($this->indexToObject[$this->index]);
    }

    /**
     * @see	\SeekableIterator::seek()
     */
    public function seek($index) {
        $this->index = $index;

        if (!$this->valid()) {
            throw new \OutOfBoundsException();
        }
    }

    /**
     * @see	\wcf\data\ITraversableObject::seekTo()
     */
    public function seekTo($objectID) {
        $this->index = array_search($objectID, $this->indexToObject);

        if ($this->index === false) {
            throw new SystemException("object id '".$objectID."' is invalid");
        }
    }

    /**
     * @see	\wcf\data\ITraversableObject::search()
     */
    public function search($objectID) {
        try {
            $this->seekTo($objectID);
            return $this->current();
        }
        catch (SystemException $e) {
            return null;
        }
    }

    /**
     * Returns the category's name.
     *
     * @return	string
     */
    public function __toString() {
        return WCF::getLanguage()->get($this->title);
    }
}
