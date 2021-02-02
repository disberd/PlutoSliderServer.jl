import PlutoBindServer
import PlutoBindServer.Pluto
using Test



"Like @async except it prints errors to the terminal. 👶"
macro asynclog(expr)
    quote
        @async try
            $(esc(expr))
        catch ex
            bt = stacktrace(catch_backtrace())
            showerror(stderr, ex, bt)
            rethrow(ex)
        end
    end
end


port = rand(3000:6000)


dir = mktempdir(; cleanup=false)

notebook_names = filter(readdir(@__DIR__)) do f
    f != "runtests.jl"
end

notebook_paths = String[]
for file in notebook_names
    newpath = joinpath(dir, file)
    write(newpath, read(file))
    push!(notebook_paths, newpath)
end
# notebook_path = joinpath(dir, "notebook.jl")
# download("https://cdn.jsdelivr.net/gh/fonsp/Pluto.jl@0.12.18/sample/Interactivity.jl", notebook_path)

try
run(`open $(dir)`)
catch end

# PlutoBindServer.run_paths([notebook_path]; create_statefiles=true, port=port)
PlutoBindServer.run_paths(notebook_paths; create_statefiles=true, port=port)



# localhost:7654/editor.html?statefile=https%3A%2F%2Fmkhj.fra1.cdn.digitaloceanspaces.com%2Finter.jlstate&notebookfile=https%3A%2F%2Fmkhj.fra1.cdn.digitaloceanspaces.com%2Finter.jl


# localhost:7654/editor.html?statefile=https%3A%2F%2Fmkhj.fra1.cdn.digitaloceanspaces.com%2Finter.jlstate&notebookfile=https%3A%2F%2Fmkhj.fra1.cdn.digitaloceanspaces.com%2Finter.jl&disable_ui=yes&bind_server_url=http%3A%2F%2Flocalhost%3A5008%2F


# http://localhost:7654/editor.html?statefile=https%3A%2F%2Fmkhj.fra1.cdn.digitaloceanspaces.com%2Finter2.jlstate&notebookfile=https%3A%2F%2Fmkhj.fra1.cdn.digitaloceanspaces.com%2Finter2.jl&disable_ui=yes&bind_server_url=http%3A%2F%2Flocalhost%3A5756%2F




# https://gallant-heisenberg-d86a8c.netlify.app/editor.html?statefile=https%3A%2F%2Fmkhj.fra1.cdn.digitaloceanspaces.com%2Finter2.jlstate&notebookfile=https%3A%2F%2Fmkhj.fra1.cdn.digitaloceanspaces.com%2Finter2.jl&disable_ui=yes&bind_server_url=https%3A%2F%2Fbind-server-demo-1.plutojl.org%2F



# localhost:1234/editor.html?statefile=https%3A%2F%2Fmkhj.fra1.cdn.digitaloceanspaces.com%2Fbind-server-tests%2Fonedefinesanother.jlstate&notebookfile=https%3A%2F%2Fmkhj.fra1.cdn.digitaloceanspaces.com%2Fbind-server-tests%2Fonedefinesanother.jl&disable_ui=yes&bind_server_url=http%3A%2F%2Flocalhost%3A5740%2F

# localhost:1234/editor.html?statefile=https%3A%2F%2Fmkhj.fra1.cdn.digitaloceanspaces.com%2Fbind-server-tests%2Fparallelpaths2.jlstate&notebookfile=https%3A%2F%2Fmkhj.fra1.cdn.digitaloceanspaces.com%2Fbind-server-tests%2Fparallelpaths2.jl&disable_ui=yes&bind_server_url=http%3A%2F%2Flocalhost%3A5740%2F

# localhost:1234/editor.html?statefile=https%3A%2F%2Fmkhj.fra1.cdn.digitaloceanspaces.com%2Fbind-server-tests%2Fbasic.jlstate&notebookfile=https%3A%2F%2Fmkhj.fra1.cdn.digitaloceanspaces.com%2Fbind-server-tests%2Fbasic.jl&disable_ui=yes&bind_server_url=http%3A%2F%2Flocalhost%3A5740%2F