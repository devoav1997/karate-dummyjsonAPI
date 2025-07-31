package dummyjson;

import com.intuit.karate.junit5.Karate;

public class CartsRunner {
    @Karate.Test
    Karate testCarts() {
        return Karate.run("Carts").relativeTo(getClass());
    }
}
