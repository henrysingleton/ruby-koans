require File.expand_path(File.dirname(__FILE__) + '/neo')

C = "top level"

class AboutConstants < Neo::Koan

  C = "nested"

  def test_nested_constants_may_also_be_referenced_with_relative_paths
    assert_equal "nested", C
  end

  def test_top_level_constants_are_referenced_by_double_colons
    assert_equal "top level", ::C #absolute?
  end

  def test_nested_constants_are_referenced_by_their_complete_path
    assert_equal "nested", AboutConstants::C #ohh complete path. so above is defaulted to the top level (root, global etc)
    assert_equal "nested", ::AboutConstants::C
  end

  # ------------------------------------------------------------------

  class Animal
    LEGS = 4
    def legs_in_animal
      LEGS
    end

    class NestedAnimal
      def legs_in_nested_animal
        LEGS #needs to be declared to actually inherit, which makes sense. 
      end
    end
  end

  def test_nested_classes_inherit_constants_from_enclosing_classes
    assert_equal 4, Animal::NestedAnimal.new.legs_in_nested_animal
  end

  # ------------------------------------------------------------------

  class Reptile < Animal
    def legs_in_reptile
      LEGS #ALSO needs to be declared to inherit, which i guess makes sense, even thought properties already inherit automatically? 
    end
  end

  def test_subclasses_inherit_constants_from_parent_classes
    assert_equal 4, Reptile.new.legs_in_reptile
  end

  # ------------------------------------------------------------------

  class MyAnimals
    LEGS = 2

    class Bird < Animal
      def legs_in_bird
        LEGS
      end
    end
  end

  def test_who_wins_with_both_nested_and_inherited_constants
    assert_equal 2, MyAnimals::Bird.new.legs_in_bird
  end

#inheritance has more impportance wich is logical. 

  # QUESTION: Which has precedence: The constant in the lexical scope,
  # or the constant from the inheritance hierarchy?

  # ------------------------------------------------------------------

  class MyAnimals::Oyster < Animal
    def legs_in_oyster
      LEGS
    end
  end

  def test_who_wins_with_explicit_scoping_on_class_definition
    assert_equal 4, MyAnimals::Oyster.new.legs_in_oyster
  end

  # QUESTION: Now which has precedence: The constant in the lexical
  # scope, or the constant from the inheritance hierarchy?  Why is it
  # different than the previous answer?
  
  # Because while you are creating a new class that is in the MyAnimals scope, it is still being created FROM the parent Aimal object, which was not in that same scope. 
end
