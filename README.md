= Example code for HTTP crawlers in Erlang

Erlang offers a very powerful and reliable foundation for building web crawlers, spiders etc. Due to its very own paradigms and
its unconventional syntax Erlang requires a willingness to learn the language from scratch.

Erlang offers a very solid basis for any kind of network services. In these examples I would to like to show some ways to build
a performant web crawler based on Erlang and the ibrowse HTTP client which I use here as replacement for the Erlang's own httpc
client due to its performance and scalability.

= Quickstart

If you already have *make*, *rebar* and *git* installed, compile the Erlang sources and install required dependencies:

    $~ make

Run the crawler:

    
    * run whatever app you want by starting it -> helloworld:start()
    * check it out at http://localhost:8080
* *NOTE:* Apps all run on :8080 (so must be run one by one)
