open class CollectionViewCell: UICollectionViewCell {
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    initialize()
    installConstraints()
  }

  open func initialize() {}

  open func installConstraints() {}
}
