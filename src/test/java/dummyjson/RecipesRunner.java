package dummyjson;

import com.intuit.karate.junit5.Karate;

public class RecipesRunner {
    @Karate.Test
    Karate testRecipes() {
        return Karate.run("Recipes").relativeTo(getClass());
    }
}
