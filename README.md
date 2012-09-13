Example code for HTTP crawlers in Erlang
========================================

Erlang offers a very powerful and reliable foundation for building web crawlers, spiders etc. Due to its very own paradigms and
its unconventional syntax Erlang requires a willingness to learn the language from scratch.

Erlang offers a very solid basis for any kind of network services. In these examples I would to like to show some ways to build
a performant web crawler based on Erlang and the ibrowse HTTP client which I use here as replacement for the Erlang's own httpc
client due to its performance and scalability.

Quickstart
==========

If you already have *rebar* installed, install the required dependencies:

    $~ ./rebar get-deps
    
... and compile the Erlang sources (dependencies and individual code):

    $~ ./rebar compile
    
Note: you can always revert all changes and cleanup the application with rebar:

    $~ ./rebar clean 
    $~ rm -f erl_crash.dump
    $~ rm -f data/*

Run the crawler:

    $~ ./run
    1> simple_crawler:start().
    
Notes: the crawler fetches static files which I have generated for explanations and for benchmarking the code.
