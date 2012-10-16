module PathNamespace

  def self.extended(base)
    base.path_namespace ''
  end

  def path_namespace(name)
    @@path_namespace = "/#{name.gsub(/^\/|\/$/, '')}/"
  end

  def get(path, opts={}, &bk)     super with_namespace(path), opts, &bk end
  def put(path, opts={}, &bk)     super with_namespace(path), opts, &bk end
  def post(path, opts={}, &bk)    super with_namespace(path), opts, &bk end
  def delete(path, opts={}, &bk)  super with_namespace(path), opts, &bk end
  def head(path, opts={}, &bk)    super with_namespace(path), opts, &bk end
  def options(path, opts={}, &bk) super with_namespace(path), opts, &bk end
  def patch(path, opts={}, &bk)   super with_namespace(path), opts, &bk end

  def with_namespace(path)
    "#{@@path_namespace}#{path.gsub(/^\//, '')}"
  end

end
