import { render, screen, waitFor } from "@testing-library/react";
import { describe, it, expect, vi, beforeEach } from "vitest";
import App from "./App";

describe("App", () => {
  beforeEach(() => {
    vi.restoreAllMocks();
  });

  it("renders the heading", () => {
    vi.spyOn(globalThis, "fetch").mockResolvedValue({
      json: () => Promise.resolve({ message: "Hello World!" }),
    } as Response);

    render(<App />);
    expect(screen.getByText("Full-Stack React & Python")).toBeInTheDocument();
  });

  it("displays loading state initially", () => {
    vi.spyOn(globalThis, "fetch").mockResolvedValue({
      json: () => Promise.resolve({ message: "Hello World!" }),
    } as Response);

    render(<App />);
    expect(screen.getByText(/Loading/)).toBeInTheDocument();
  });

  it("fetches and displays the server message", async () => {
    vi.spyOn(globalThis, "fetch").mockResolvedValue({
      json: () => Promise.resolve({ message: "Hello World!" }),
    } as Response);

    render(<App />);

    await waitFor(() => {
      expect(screen.getByText(/Hello World!/)).toBeInTheDocument();
    });
  });

  it("displays error message on fetch failure", async () => {
    vi.spyOn(globalThis, "fetch").mockRejectedValue(new Error("Network error"));

    render(<App />);

    await waitFor(() => {
      expect(screen.getByText(/Failed to connect to server/)).toBeInTheDocument();
    });
  });
});
