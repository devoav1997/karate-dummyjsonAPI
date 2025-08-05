package dummyjson;

import com.intuit.karate.junit5.Karate;

class PostsRunner {

    @Karate.Test
    Karate testPosts() {
        return Karate.run("Posts").relativeTo(getClass());
    }
}
