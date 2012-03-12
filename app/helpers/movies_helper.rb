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

  def checked?(rating, rating_keys)
    if rating_keys
      rating_keys.include?(rating)
    else
      false
    end
  end
end
