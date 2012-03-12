module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def hilite?(table, sort)
    if table == sort
      "hilite"
    end
  end
end
