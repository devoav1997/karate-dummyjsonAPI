package dummyjson;

import com.intuit.karate.junit5.Karate;

public class AuthRunner {
    @Karate.Test
    Karate testAuth() {
        return Karate.run("Auth").relativeTo(getClass());
    }
}
