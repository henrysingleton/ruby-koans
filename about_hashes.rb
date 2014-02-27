require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutHashes < Neo::Koan
  def test_creating_hashes
    empty_hash = Hash.new
    assert_equal Hash, empty_hash.class
    assert_equal({}, empty_hash) #so hash is different to array cause it has curly braces! im sure other things are different too. Ahh so they are associatiave arrays. cool. 
    assert_equal 0, empty_hash.size
    
    some_oter_hash = empty_hash.class.new #so class is an actualu representation of the uninstantiated class? That is pretty cool. 
    
  end

  def test_hash_literals
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.size
  end

  def test_accessing_hashes
    hash = { :one => "uno", :two => "dos" }
    assert_equal "uno", hash[:one]
    assert_equal "dos", hash[:two]
    assert_equal nil, hash[:doesnt_exist]
  end

  def test_accessing_hashes_with_fetch
    hash = { :one => "uno" }
    assert_equal "uno", hash.fetch(:one)
    assert_raise(Exception) do # I was right the first time! Coda's casing was the problem! Not mine!
      hash.fetch(:doesnt_exist)
    end

    # THINK ABOUT IT:
    #
    # Why might you want to use #fetch instead of #[] when accessing hash keys?
    # I guess if you wanted to cause an error? 
  end

  def test_changing_hashes
    hash = { :one => "uno", :two => "dos" }
    hash[:one] = "eins"

    expected = { :one => "eins", :two => "dos" }
    assert_equal expected, hash

    # Bonus Question: Why was "expected" broken out into a variable
    # rather than used as a literal?
  end

  def test_hash_is_unordered
    hash1 = { :one => "uno", :two => "dos" }
    hash2 = { :two => "dos", :one => "uno" }

    assert_equal true, hash1 == hash2
  end

  def test_hash_keys
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.keys.size
    assert_equal true, hash.keys.include?(:one)
    assert_equal true, hash.keys.include?(:two)
    assert_equal Array, hash.keys.class
  end

  def test_hash_values
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.values.size
    assert_equal true, hash.values.include?("uno")
    assert_equal true, hash.values.include?("dos")
    assert_equal Array, hash.values.class
  end

  def test_combining_hashes
    hash = { "jim" => 53, "amy" => 20, "dan" => 23 }
    new_hash = hash.merge({ "jim" => 54, "jenny" => 26 })

    assert_equal true, hash != new_hash

    expected = { "jim" => 54, "amy" => 20, "dan" => 23, "jenny" => 26 }
    assert_equal true, expected == new_hash
  end

  def test_default_value #so you can set default values for new members(?) of the hash. 
    hash1 = Hash.new
    hash1[:one] = 1

    assert_equal 1, hash1[:one]
    assert_equal nil, hash1[:two]

    hash2 = Hash.new("dos")
    hash2[:one] = 1

    assert_equal 1, hash2[:one]
    assert_equal "dos", hash2[:two] 
  end

  def test_default_value_is_the_same_object
    hash = Hash.new([]) #so default value is empty array...

    hash[:one] << "uno" #i guess this is a way of assigning values to the hash? why does an equals not suffice? 
    hash[:two] << "dos" #uhhh does this add it to all elements of the hash? That wouldnt make much sense to me...
    
	

    assert_equal ["uno","dos"], hash[:one] # yeah its for appending, but i dont get how it has worked in this one...
    assert_equal ["uno","dos"], hash[:two]
    assert_equal ["uno","dos"], hash[:three] #this is the same as well?! 
    
    # is it inheriting??? is it a reference?? I do not get this... 

    assert_equal true, hash[:one].object_id == hash[:two].object_id
    
    # oh. so they are ALL the same objects? Why would you want this? 
  end

  def test_default_value_with_block
    hash = Hash.new {|hash, key| hash[key] = [] } #i guess this is doing the same thing as above? 

    hash[:one] << "uno"
    hash[:two] << "dos"

    assert_equal ["uno"], hash[:one]
    assert_equal ["dos"], hash[:two]
    assert_equal [], hash[:three]
    
    # yeah i dont get any of this either... why is it not the same as the first one? 
  end
end
