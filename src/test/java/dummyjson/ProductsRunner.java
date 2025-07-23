package dummyjson;

import com.intuit.karate.junit5.Karate;

public class ProductsRunner {
    @Karate.Test
    Karate testProducts() {
        return Karate.run("classpath:dummyjson/Products.feature");
    }
}
