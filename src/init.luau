--!optimize 2
--!strict

local Promise = require(script.Parent.Promise)

local Async = require(script.Async)
local AsyncMulti = require(script.AsyncMulti)
local Await = require(script.Await)
local AwaitMulti = require(script.AwaitMulti)
local FastAsync = require(script.FastAsync)
local FastAsyncMulti = require(script.FastAsyncMulti)

export type Error = Promise.Error
export type ErrorKind = Promise.ErrorKind
export type Status = Promise.Status

export type Promise<T...> = Promise.TypedPromise<T...>
export type VoidPromise = Promise.Promise

--[=[
	Utilities for working with Promises.
	@class PromiseUtilities
]=]
local PromiseUtilities = table.freeze({
	Async = Async;
	AsyncMulti = AsyncMulti;
	Await = Await;
	AwaitMulti = AwaitMulti;
	FastAsync = FastAsync;
	FastAsyncMulti = FastAsyncMulti;

	Promise = Promise;
})

return PromiseUtilities
