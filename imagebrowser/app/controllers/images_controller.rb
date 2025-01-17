class ImagesController < UICollectionViewController

  attr_accessor :image_urls

  IMAGES_CELL_ID = "ImagesCell"

  def self.new(args = {})
    # Set layout
    layout = UICollectionViewFlowLayout.alloc.init
    self.alloc.initWithCollectionViewLayout(layout)
  end

  def viewDidLoad
    super

    rmq.stylesheet = ImagesControllerStylesheet

    collectionView.tap do |cv|
      cv.registerClass(ImagesCell, forCellWithReuseIdentifier: IMAGES_CELL_ID)
      cv.delegate = self
      cv.dataSource = self
      cv.allowsSelection = true
      cv.allowsMultipleSelection = false
      rmq(cv).apply_style :collection_view
    end
  end

  def numberOfSectionsInCollectionView(view)
    1
  end

  def collectionView(view, numberOfItemsInSection: section)
    @image_urls.length
  end

  def collectionView(view, cellForItemAtIndexPath: index_path)
    view.dequeueReusableCellWithReuseIdentifier(IMAGES_CELL_ID, forIndexPath: index_path).tap do |cell|
      rmq.build(cell) unless cell.reused

      # Update cell's data here
      cell.update(@image_urls[index_path.row])
    end
  end

  def collectionView(view, didSelectItemAtIndexPath: index_path)
    cell = view.cellForItemAtIndexPath(index_path)
    image_popup(@image_urls[index_path.row])
  end

  def image_popup(image_url)
    rmq.wrap(rmq.app.window).tap do |o|
      o.append(UIView, :overlay).animations.fade_in.on(:tap) do |sender|
        o.find(sender, :overlay_image, :overlay_note).hide.remove
      end

      o.append(UIImageView, :overlay_image).get.url = image_url
      o.append(UILabel, :overlay_note)
    end
  end

end
